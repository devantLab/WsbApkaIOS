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

class InfosController: UIViewController {
    
    @IBOutlet var views: [UIView]!
    @IBOutlet var buttons: [UIButton]!
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
            SVProgressHUD.setForegroundColor(UIColor(red: 0.00, green: 0.32, blue: 0.91, alpha: 1.0))
            SVProgressHUD.show()
            DispatchQueue.global(qos: .userInitiated).async {
                let remotePDFDocumentURLPath = "http://devstreaming.apple.com/videos/wwdc/2016/201h1g4asm31ti2l9n1/201/201_internationalization_best_practices.pdf"
                let remotePDFDocumentURL = URL(string: remotePDFDocumentURLPath)!
                let document = PDFDocument(url: remotePDFDocumentURL)!
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    let readerController = PDFViewController.createNew(with: document)
                    readerController.title = ""
                    readerController.backgroundColor = .white
                    self.navigationController?.pushViewController(readerController, animated: true)
                }
            }
            
            
            
            
        default:
            print("InfoController error")
        }
    }
    
    
}
