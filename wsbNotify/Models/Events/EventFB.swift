//
//  EventFB.swift
//  WSB
//
//  Created by apple on 17.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
enum EventFB: String {
    case id = "event_id"
    case title = "event_title"
    case description = "event_description"
    case term = "event_term" // remove
    case date = "event_date"
    case time = "event_time"
    case place = "event_place" // remove
    case city = "event_city"
    case street = "event_street"
    case image = "event_image_url"
    case latitude = "event_latitude"
    case longitude = "event_longitude"
    case clicks = "event_clicks"
    case link = "event_link"
    /*
     f let dict = snapshot.value as? [String: Any] {
     let id: Int = dict["event_id"] as! Int
     let title: String = dict["event_title"] as! String
     let description: String = dict["event_description"] as! String
     let term: String = dict["event_term"] as! String
     let date = self.stringToDateFormat(term: term)
     let place: String = dict["event_place"] as! String
     let imageURL: String = dict["event_image_url"] as! String
     let clicks: Int = dict["event_clicks"] as! Int
    */
    
    
}
