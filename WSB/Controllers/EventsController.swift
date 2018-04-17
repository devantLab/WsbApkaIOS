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

class EventsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak private var tableView: UITableView!
    private let rootRef = Database.database().reference()
    private var events = [Event]()
    
    // MARK: PULL TO REFRESH
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = tabBarController?.tabBar.barTintColor
        refreshControl.addTarget(self, action: #selector(loadEvents), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.refreshControl = self.refresher
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadEvents()
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
        let eventsRef = rootRef.child("events")
        
        eventsRef.observe(DataEventType.childAdded, with: {(snapshot) in
            
            if let dict = snapshot.value as? [String: Any] {
                let id: Int = dict["event_id"] as! Int
                let title: String = dict["event_title"] as! String
                let description: String = dict["event_description"] as! String
                let term: String = dict["event_term"] as! String
                let date = self.stringToDateFormat(term: term)
                let place: String = dict["event_place"] as! String
                let imageURL: String = dict["event_image_url"] as! String
                let clicks: Int = dict["event_clicks"] as! Int
                let event = Event(id: id, title: title, description: description, term: date, place: place, imageURL: imageURL, clicks: clicks)
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
        cell.eventDescription?.text = event.eventDescription
        cell.eventImage.sd_setImage(with: URL(string: event.eventImageURL), placeholderImage: UIImage(named: "placeholder.png"))
        let date = event.eventTerm
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        cell.eventMonth.text = monthName(month: month)
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
            let calendar = Calendar.current
            let date = event.eventTerm
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            destination.eventTitle = event.eventTitle
            destination.eventDate = "\(day) \(monthName(month: month)) \(year)"
            destination.eventTime = "\(hour):\(minute)"
            
            // TODO: trim city and street
            destination.eventCity = event.eventPlace
            // destination.eventStreet = ?
            
            destination.eventImageURL = event.eventImageURL
            destination.eventDescription = event.eventDescription
            
            // TODO: coordinates
            //destination.coordinates = ["latitude": event.coordinate["latitude"], "longitude": event.coordinate["longitude"]]
            destination.coordinates = ["latitude": 40.730610, "longitude": -73.935242]
        }
    }
    
    // MARK: MONTHNAME METHOD
    func monthName(month: Int) -> String {
        switch month {
        case 1:
            return "Jan."
        case 2:
            return "Feb."
        case 3:
            return "Mar."
        case 4:
            return "Apr."
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug."
        case 9:
            return "Sept."
        case 10:
            return "Oct."
        case 11:
            return "Nov."
        case 12:
            return "Dec."
        default:
            return "Error"
        }
    }
    func stringToDateFormat(term: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let date = dateFormatter.date(from: term)!
        return date
    }
    
}
