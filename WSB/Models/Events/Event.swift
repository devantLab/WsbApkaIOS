//
//  Event.swift
//  WSB
//
//  Created by apple on 05.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation

class Event {
    let eventId: Int
    let eventTitle: String
    let eventDescription: String
    let eventCity: String
    let eventStreet: String
    let eventDate: Date
    let eventTimeStart: String
    let eventTimeEnd: String
    let eventClicks: Int
    let eventIsWSB: Bool
    let eventLink: String
    let eventImage: String
    let eventLatitude: Double
    let eventLongitude: Double
    

    init(id: Int, title: String, description: String, city: String, street: String, date: Date, timeStart: String, timeEnd: String, clicks: Int, isWsbEvent: Bool, link: String, image: String, latitude: Double, longitude: Double) {
        eventId = id
        eventTitle = title
        eventDescription = description
        eventCity = city
        eventStreet = street
        eventDate = date
        eventTimeStart = timeStart
        eventTimeEnd = timeEnd
        eventClicks = clicks
        eventIsWSB = isWsbEvent
        eventLink = link
        eventImage = image
        eventLatitude = latitude
        eventLongitude = longitude
    }
    
}
