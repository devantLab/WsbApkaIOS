//
//  InfosController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//
import UIKit
import PDFReader
import SVProgressHUD
import LocalizationKit
class InfosController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    @IBOutlet var buttons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
        roundCorners()
        setRealtimeLanguage()
        setLanguage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func buttonClick(_ sender: UIButton) {
        sender.flash()
        
        switch sender.tag {
        case 1:
            pushPDFViewController()
        default:
            print("InfoController error")
        }
    }
    
    fileprivate func pushPDFViewController() {
        SVProgressHUD.setForegroundColor(UIColor(red: 0.00, green: 0.32, blue: 0.91, alpha: 1.0))
        SVProgressHUD.show()
        DispatchQueue.global(qos: .userInitiated).async {
            //                let remotePDFDocumentURLPath = "http://devstreaming.apple.com/videos/wwdc/2016/201h1g4asm31ti2l9n1/201/201_internationalization_best_practices.pdf"
            //                let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath)!
            //                let document = PDFDocument(url: remotePDFDocumentURL)!
            let documentFileURL = Bundle.main.url(forResource: "test", withExtension: "pdf")!
            let document = PDFDocument(url: documentFileURL)!
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let readerController = PDFViewController.createNew(with: document)
                readerController.title = ""
                readerController.backgroundColor = .white
                self.navigationController?.pushViewController(readerController, animated: true)
            }
        }
    }
    func roundCorners(){
        views.forEach({view in
            view.round(corners: .allCorners, radius: 10)
        })
    }
    // MARK: LANGUAGE SETUP
    @objc func setLanguage(){
        buttons[0].setTitle(insuranceButtonText(), for: .normal)
        buttons[1].setTitle(bankingButtonText(), for: .normal)
        buttons[2].setTitle(lawButtonText(), for: .normal)
        buttons[3].setTitle(placesButtonText(), for: .normal)
        buttons[4].setTitle(appsButtonText(), for: .normal)
        
    }
    func setRealtimeLanguage(){
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "Ubezpieczenie"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "Bankowosc"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "PolskiePrawo"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "CiekaweMiejsca"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setLanguage), name: Localization.localizationEvent(localizationKey: "Aplikacje"), object: nil)
    }
    
    @objc func insuranceButtonText() -> String { return Localization.get("Ubezpieczenie", alternate: "Ubezpieczenie") }
    @objc func bankingButtonText() -> String { return Localization.get("Bankowosc", alternate: "Bankowosc") }
    @objc func lawButtonText() -> String { return Localization.get("PolskiePrawo", alternate: "Polskie prawo") }
    @objc func placesButtonText() -> String { return Localization.get("CiekaweMiejsca", alternate: "Ciekawe miejsca") }
    @objc func appsButtonText() -> String { return Localization.get("Aplikacje", alternate: "Aplikacje") }
}
