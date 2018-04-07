//
//  Event.swift
//  WSB
//
//  Created by apple on 05.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var eventTitle: String = ""
    @objc dynamic var eventTerm: Date = Date()
    @objc dynamic var eventDescription: String = ""
    @objc dynamic var eventPlace: String = ""
    @objc dynamic var eventImage: String = ""
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
}
