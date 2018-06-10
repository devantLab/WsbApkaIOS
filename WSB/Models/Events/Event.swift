//
//  Event.swift
//  WSB
//
//  Created by apple on 05.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation

struct Event: Decodable {
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
    
    
}
