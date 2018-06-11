//
//  UniversityController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit
import LocalizationKit

class UniversityController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    @IBOutlet var buttons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        setRealtimeLanguage()
        setLanguage(buttons: buttons)
        roundCorners(views: views)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func buttonClick(_ sender: UIButton) {
        sender.flash()
    }
    func roundCorners(views: [UIView]){
        views.forEach({view in
            view.round(corners: .allCorners, radius: 10)
        })
    }
    // MARK: LANGUAGE SETUP
    @objc func setLanguage(buttons: [UIButton]){
        buttons[0].setTitle(notificationButtonText(), for: .normal)
        buttons[1].setTitle(openingHoursButtonText(), for: .normal)
        buttons[2].setTitle(universityMapButtonText(), for: .normal)
        buttons[3].setTitle(careersOfficeButtonText(), for: .normal)
        buttons[4].setTitle(calendarButtonText(), for: .normal)
    }
    func setRealtimeLanguage(){
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "DoniesDokumenty"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "GodzinyOtwarcia"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "MapaUczelni"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "BiuroKarier"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "Kalendarz"), object: nil)

    }
    @objc func notificationButtonText() -> String { return Localization.get("DoniesDokumenty", alternate: "Donieś dokumenty") }
    @objc func openingHoursButtonText() -> String { return Localization.get("GodzinyOtwarcia", alternate: "Godziny otwarcia") }
    @objc func universityMapButtonText() -> String { return Localization.get("MapaUczelni", alternate: "Mapa uczelni") }
    @objc func careersOfficeButtonText() -> String { return Localization.get("BiuroKarier", alternate: "Biuro karier") }
    @objc func calendarButtonText() -> String { return Localization.get("Kalendarz", alternate: "Kalendarz") }

    
}

