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
   
    //STRINGS
    @objc func notificationButtonText() -> String { return Localization.get("DoniesDokumenty", alternate: "Donieś dokumenty") }
    @objc func openingHoursButtonText() -> String { return Localization.get("GodzinyOtwarcia", alternate: "Godziny otwarcia") }
    @objc func universityMapButtonText() -> String { return Localization.get("MapaUczelni", alternate: "Mapa uczelni") }
    @objc func careersOfficeButtonText() -> String { return Localization.get("BiuroKarier", alternate: "Biuro karier") }
    @objc func calendarButtonText() -> String { return Localization.get("Kalendarz", alternate: "Kalendarz") }



    override func viewDidLoad() {
        super.viewDidLoad()
        setLanguage()
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "DoniesDokumenty"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "GodzinyOtwarcia"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "MapaUczelni"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "BiuroKarier"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "Kalendarz"), object: nil)

        views.forEach({view in
            view.round(corners: .allCorners, radius: 10)
        })
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func buttonClick(_ sender: UIButton) {
        sender.flash()
    }
    @objc func setLanguage(){
        buttons[0].setTitle(notificationButtonText(), for: .normal)
        buttons[1].setTitle(openingHoursButtonText(), for: .normal)
        buttons[2].setTitle(universityMapButtonText(), for: .normal)
        buttons[3].setTitle(careersOfficeButtonText(), for: .normal)
        buttons[4].setTitle(calendarButtonText(), for: .normal)

    }
    
}

