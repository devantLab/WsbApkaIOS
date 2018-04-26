//
//  ContainerController.swift
//  WSB
//
//  Created by apple on 18.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    @IBOutlet weak var sideMenuConstraint: NSLayoutConstraint!
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func toggleSideMenu(){
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstraint.constant = -280
        } else {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .right {
            sideMenuOpen = true
            sideMenuConstraint.constant = 0
        }
        if sender.direction == .left {
            sideMenuOpen = false
            sideMenuConstraint.constant = -280
        }
    }
}
