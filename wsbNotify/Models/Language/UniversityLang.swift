//
//  UniversityLang.swift
//  WSB
//
//  Created by apple on 08.06.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation

class UniversityLang: LanguageManager {
    
    static let DoniesDokumenty: [String] = ["DoniesDokumenty", "Donieś dokumenty"]
    static let GodzinyOtwarcia: [String] = ["GodzinyOtwarcia", "Godziny otwarcia"]
    static let MapaUczelni: [String] = ["MapaUczelni", "Mapa uczelni"]
    static let BiuroKarier: [String] = ["BiuroKarier", "Biuro karier"]
    static let Kalendarz: [String] = ["Kalendarz", "Kalendarz"]
    
    override init(buttonsKeys: [UIButton : [String]], LabelsKeys: [UILabel : [String]]) {
        super.init(buttonsKeys: buttonsKeys, LabelsKeys: LabelsKeys)
    }
}

