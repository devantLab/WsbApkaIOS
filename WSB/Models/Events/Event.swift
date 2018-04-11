//
//  Event.swift
//  WSB
//
//  Created by apple on 05.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation

class Event {
    var eventId: Int
    var eventTitle: String
    var eventDescription: String
    var eventTerm: Date
    var eventPlace: String
    var eventImageURL: String
    var eventClicks: Int
    
    init(id: Int, title: String, description: String, term: Date, place: String, imageURL: String, clicks: Int) {
        eventId = id
        eventTitle = title
        eventDescription = description
        eventTerm = term
        eventPlace = place
        eventImageURL = imageURL
        eventClicks = clicks
    }
    
}
