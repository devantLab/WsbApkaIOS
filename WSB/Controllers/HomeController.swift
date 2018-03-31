//
//  HomeController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var expandableView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var eventView: UIView!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var alertArrow: UIImageView!
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var expandableViewConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        //button cornerRadius
        buttons.forEach { button in
            button.layer.cornerRadius = 10
        }
        //hiding the expandableView
        self.expandableViewConstraint.constant = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func alertButtonClick(_ sender: Any) {
        expandAlertButton()
    }
    
    
    func expandAlertButton() {
        view.layoutIfNeeded()
        let height: CGFloat = (self.expandableViewConstraint.constant == 0) ? 150 : 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.expandableViewConstraint.constant = height
            self.alertArrow.transform = self.alertArrow.transform.rotated(by: CGFloat(Double.pi))
            self.view.layoutIfNeeded()
        })
    }
    
    

}

