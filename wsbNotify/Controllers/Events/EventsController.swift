//
//  EventsController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import LocalizationKit

class EventsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak private var tableView: UITableView!
    private let rootRef = Database.database().reference()
    private var events = [Event]()
    
    // MARK: PULL TO REFRESH
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 0.00, green: 0.32, blue: 0.91, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(loadEvents), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.refreshControl = self.refresher
        loadEvents()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @objc func loadEvents() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let activityView = UIActivityIndicatorView()
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityView.color = tabBarController?.tabBar.barTintColor
        activityView.startAnimating()
        self.view.addSubview(activityView)
        let eventsRef = rootRef.child("Events")
        eventsRef.observe(DataEventType.childAdded, with: {(snapshot) in
            guard let dict = snapshot.value as? [String: Any] else { return }
            do {
                let event: Event = EventDataParser.parse(dict: dict)
                self.events.append(event)
                self.tableView.reloadData()
            }
            
            activityView.stopAnimating()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            self.refresher.endRefreshing()
            
        })
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let event = events[indexPath.row]
        cell.eventTitle?.text = event.eventTitle
        cell.eventPlace?.text = "\(event.eventCity), \(event.eventStreet)"
        cell.eventTime?.text = event.eventTimeEnd == "0" ? "\(event.eventTimeStart)" : "\(event.eventTimeStart) - \(event.eventTimeEnd)"
        cell.eventImage.sd_setImage(with: URL(string: event.eventImage), placeholderImage: UIImage(named: "placeholder.png"))
        let date = event.eventDate
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        cell.eventMonth.text = MonthConverter.monthName(month: month, language: Localization.language!.key)
        cell.eventDay.text = String(day)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.eventImage.round(corners: .allCorners, radius: 10)
        cell.dateView.round(corners: .allCorners, radius: 10)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "eventDetail", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EventDetailController {
            let event = events[(tableView.indexPathForSelectedRow?.row)!]
            destination.event = event
            destination.coordinates = ["latitude": event.eventLatitude, "longitude": event.eventLongitude]
            
        }
    }
    
    
}
