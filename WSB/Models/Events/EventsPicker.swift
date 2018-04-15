//
//  EventsPicker.swift
//  WSB
//
//  Created by apple on 05.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

//import Foundation
//import Firebase
//class EventsPicker{
//
//    let rootRef = Database.database().reference()
//    var events = [Event]()
//    @objc func loadEvents() {
//
//
//        let eventsRef = rootRef.child("events")
//
//        eventsRef.observe(DataEventType.childAdded, with: {(snapshot) in
//
//            if let dict = snapshot.value as? [String: Any] {
//                let id: Int = dict["event_id"] as! Int
//                let title: String = dict["event_title"] as! String
//                let description: String = dict["event_description"] as! String
//                let term: String = dict["event_term"] as! String
//                let date = self.stringToDateFormat(term: term)
//                let place: String = dict["event_place"] as! String
//                let imageURL: String = dict["event_image_url"] as! String
//                let clicks: Int = dict["event_clicks"] as! Int
//                let event = Event(id: id, title: title, description: description, term: date, place: place, imageURL: imageURL, clicks: clicks)
//                self.events.append(event)
//                self.tableView.reloadData()
//            }
//
//            activityView.stopAnimating()
//            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
//            self.refresher.endRefreshing()
//
//        })
//    }
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return events.count
//    }
//
//
//    // MARK: MONTHNAME METHOD
//    func monthName(month: Int) -> String {
//        switch month {
//        case 1:
//            return "Jan."
//        case 2:
//            return "Feb."
//        case 3:
//            return "Mar."
//        case 4:
//            return "Apr."
//        case 5:
//            return "May"
//        case 6:
//            return "June"
//        case 7:
//            return "July"
//        case 8:
//            return "Aug."
//        case 9:
//            return "Sept."
//        case 10:
//            return "Oct."
//        case 11:
//            return "Nov."
//        case 12:
//            return "Dec."
//        default:
//            return "Error"
//        }
//    }
//    func stringToDateFormat(term: String) -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        dateFormatter.timeZone = TimeZone(identifier:"GMT")
//        let date = dateFormatter.date(from: term)!
//        return date
//    }
//
//}
//
