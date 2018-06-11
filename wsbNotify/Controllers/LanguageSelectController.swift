//
//  LanguageSelectController.swift
//  wsbNotify
//
//  Created by apple on 11.06.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit

class LanguageSelectController: UIViewController {
    
    @IBOutlet weak var polishFlagImageView: UIImageView!
    @IBOutlet weak var ukFlagImageView: UIImageView!
    @IBOutlet weak var russianFlagImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var helloLabel: UILabel!
    let hello: [String] = ["Hello", "Witaj", "Здравствуйте"]
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let polishTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let ukTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let russianTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        polishFlagImageView.isUserInteractionEnabled = true
        polishFlagImageView.addGestureRecognizer(polishTapGestureRecognizer)
        ukFlagImageView.isUserInteractionEnabled = true
        ukFlagImageView.addGestureRecognizer(ukTapGestureRecognizer)
        russianFlagImageView.isUserInteractionEnabled = true
        russianFlagImageView.addGestureRecognizer(russianTapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if tappedImage.contentMode == .scaleAspectFit {
            tappedImage.contentMode = .scaleAspectFill
            switch tappedImage.tag {
            case 0:
                ukFlagImageView.contentMode = .scaleAspectFit
                russianFlagImageView.contentMode = .scaleAspectFit
                labelTextAnimation(text: "Polski")
            case 1:
                russianFlagImageView.contentMode = .scaleAspectFit
                polishFlagImageView.contentMode = .scaleAspectFit
                labelTextAnimation(text: "English")
            case 2:
                polishFlagImageView.contentMode = .scaleAspectFit
                ukFlagImageView.contentMode = .scaleAspectFit
                labelTextAnimation(text: "русский")
            default:
                break
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func labelTextAnimation(text: String) {
        UIView.transition(with: languageLabel,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.languageLabel.text = text
            }, completion: nil)
    }

}
