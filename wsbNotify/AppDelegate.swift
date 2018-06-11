//
//  AppDelegate.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import LocalizationKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    override init() {
        FirebaseApp.configure()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Init LocalizationKit with Live update
        Localization.start(appKey: Constants.LOCALIZATION_KIT_API_KEY, live: true)
        
        return true
    }
}

