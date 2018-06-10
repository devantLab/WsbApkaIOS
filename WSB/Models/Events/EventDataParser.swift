//
//  EventDataParser.swift
//  WSB
//
//  Created by apple on 22.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
class EventDataParser: EventFirebaseProperties {
    static func parse(dict: [String: Any]) -> Event {
        let id: Int = dict[ID] as? Int ?? -1
        let title: String = dict[TITLE] as? String ?? ""
        let description: String = dict[DESCRIPTION] as? String ?? ""
        let dateString: String = dict[DATE] as? String ?? ""
        let date = (dateString != "") ? stringToDateFormat(term: dateString) : Date()
        let timeStart: String = dict[TIME_START] as? String ?? ""
        let timeEnd: String = dict[TIME_END] as? String ?? ""
        let image: String = dict[IMAGE] as? String ?? ""
        let clicks: String = dict[CLICKS] as? String ?? "0"
        let clicksInt: Int = Int(clicks)!
        let isWsbEvent: Bool = dict[IS_WSB_EVENT] as? Bool ?? false
        let link: String = dict[LINK] as? String ?? ""
        let city: String = dict[CITY] as? String ?? ""
        let street: String = dict[STREET] as? String ?? ""
        let latitude: String = dict[LATITUDE] as? String ?? "0.0"
        let longitude: String = dict[LONGITUDE] as? String ?? "0.0"
        let latitudeD: Double = Double(latitude)!
        let longitudeD: Double = Double(longitude)!
        let event = Event(eventId: id, eventTitle: title, eventDescription: description, eventCity: city, eventStreet: street, eventDate: date, eventTimeStart: timeStart, eventTimeEnd: timeEnd, eventClicks: clicksInt, eventIsWSB: isWsbEvent, eventLink: link, eventImage: image, eventLatitude: latitudeD, eventLongitude: longitudeD)
        return event
    }
    
    static func stringToDateFormat(term: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_FORMAT
        dateFormatter.timeZone = TimeZone(identifier: TIMEZONE)
        let date = dateFormatter.date(from: term)!
        return date
    }
    // TODO: increment Clicks method 
    static func incrementClicks(clicks: String) -> String {
        if var intClicks: Int = Int(clicks) {
            intClicks += 1
            let stringClicks = String(intClicks)
            return stringClicks
        }
        return clicks
    }
    
    
}
