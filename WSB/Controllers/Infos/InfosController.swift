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
    @objc func notificationButtonText() -> String { return Localization.get("DoniesDokumenty", alternate: "Donieś dokumenty") }
    @objc func openingHoursButtonText() -> String { return Localization.get("GodzinyOtwarcia", alternate: "Godziny otwarcia") }
    @objc func universityMapButtonText() -> String { return Localization.get("MapaUczelni", alternate: "Mapa uczelni") }
    @objc func careersOfficeButtonText() -> String { return Localization.get("BiuroKarier", alternate: "Biuro karier") }
    @objc func calendarButtonText() -> String { return Localization.get("Kalendarz", alternate: "Kalendarz") }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        views.forEach({view in
            view.round(corners: .allCorners, radius: 10)
        })
        
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
    
    fileprivate func setLanguage() {
        
    }

}
