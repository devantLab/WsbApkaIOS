//
//  InfosController.swift
//  WSB
//
//  Created by apple on 30.03.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit

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
        
    }
    
    
}
