//
//  Constants.swift
//  WSB
//
//  Created by apple on 06.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
struct Constants {
    // MARK: Realm
    static let REALM_INSTANCE_ADDRESS = "intelligent-plastic-ball.us1a.cloud.realm.io"

    static let REALM_AUTH_URL  = URL(string: "https://\(REALM_INSTANCE_ADDRESS)")!
    static let REALM_CLASS = "events"
    static let REALM_URL = URL(string: "realms://\(REALM_INSTANCE_ADDRESS)/\(REALM_CLASS)")!
    
    static let REALM_USERNAME = "admin"
    static let REALM_PASSWORD = "admin"
    
    // MARK: ForecastIO
    static let FORECAST_API_KEY = "4f71aa59dfaa7e14d3084e9fd27f0240"
}
