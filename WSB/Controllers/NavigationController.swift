//
//  EventNavigationController.swift
//  WSB
//
//  Created by apple on 14.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "sciana_ios_414x86")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
