//
//  Constants.swift
//  WSB
//
//  Created by apple on 06.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
struct Constants {

    static let MY_INSTANCE_ADDRESS = "intelligent-plastic-ball.us1a.cloud.realm.io" 

    static let AUTH_URL  = URL(string: "https://\(MY_INSTANCE_ADDRESS)")!
    static let REALM_URL = URL(string: "realms://\(MY_INSTANCE_ADDRESS)/events")!
    
    static let USERNAME = "admin"
    static let PASSWORD = "admin"
}
