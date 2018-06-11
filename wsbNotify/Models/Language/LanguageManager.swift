//
//  LanguageManager.swift
//  WSB
//
//  Created by apple on 08.06.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
import LocalizationKit

class LanguageManager {
    //[String] array first element ([0]) = key, second element ([1]) = alternate string
    var buttonsKeys: [UIButton : [String]]
    var labelsKeys: [UILabel : [String]]
    
    init(buttonsKeys : [UIButton : [String]], LabelsKeys : [UILabel : [String]]) {
        self.buttonsKeys = buttonsKeys
        self.labelsKeys = LabelsKeys
    }
    
    func get(key: String, alternate: String) -> String {
        return Localization.get(key, alternate: alternate)
    }
    
    @objc func setLanguage(){
        for buttonKey in buttonsKeys {
            buttonKey.key.setTitle(get(key: buttonKey.value[0], alternate: buttonKey.value[1]), for: .normal)
        }
        for labelKey in labelsKeys {
            labelKey.key.text = get(key: labelKey.value[0], alternate: labelKey.value[1])
        }
        
    }
    
    private func getKeys() -> [String]{
        var keyArray: [String] = []
        for buttonKey in buttonsKeys {
            keyArray.append(buttonKey.value[0])
        }
        for labelKey in labelsKeys {
            keyArray.append(labelKey.value[0])
        }
        return keyArray
    }
}
