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
            if let dict = snapshot.value as? [String: Any] {
                let id: Int = dict["eventId"] as! Int
                let title: String = dict["eventTitle"] as! String
                let description: String = dict["eventDescription"] as! String
                let dateString: String = dict["eventDate"] as! String
                let date = self.stringToDateFormat(term: dateString)
                let timeStart: String = dict["eventTimeStart"] as! String
                let timeEnd: String = dict["eventTimeEnd"] as! String
                let image: String = dict["eventImage"] as! String
                let clicks: String = dict["eventClicks"] as! String
                let clicksInt: Int = Int(clicks)!
                let isWsbEvent: Bool = dict["eventIsWSB"] as! Bool
                let link: String = dict["eventLink"] as! String
                let city: String = dict["eventCity"] as! String
                let street: String = dict["eventStreet"] as! String
                let latitude: String = dict["eventLatitude"] as! String
                let longitude: String = dict["eventLongitude"] as! String
                let latitudeD: Double = Double(latitude)!
                let longitudeD: Double = Double(longitude)!
                let event = Event(id: id, title: title, description: description, city: city, street: street, date: date, timeStart: timeStart, timeEnd: timeEnd, clicks: clicksInt, isWsbEvent: isWsbEvent, link: link, image: image, latitude: latitudeD, longitude: longitudeD)
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
            let date = event.eventDate
            let year = calendar.component(.year, from: date)
            let month = calendar.component(.month, from: date)
            let day = calendar.component(.day, from: date)
            let hour = calendar.component(.hour, from: date)
            let minute = calendar.component(.minute, from: date)
            destination.eventTitle = event.eventTitle
            destination.eventDate = "\(day) \(monthName(month: month)) \(year)"
            destination.eventTime = "\(hour):\(minute)"
            destination.eventCity = event.eventCity
            destination.eventStreet = event.eventStreet
            destination.eventImageURL = event.eventImage
            destination.eventDescription = event.eventDescription
            destination.coordinates = ["latitude": event.eventLatitude, "longitude": event.eventLongitude]
            
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
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = TimeZone(identifier:"GMT")
        let date = dateFormatter.date(from: term)!
        return date
    }
    
}
