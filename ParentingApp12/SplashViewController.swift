//
//  SplashViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2020/01/27.
//  Copyright © 2020 咲枝友則. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if UserDefaults.standard.string(forKey: "Name") == nil{
            performSegue(withIdentifier: "login", sender: nil)
        }else{
            performSegue(withIdentifier: "tabBarController", sender: nil)
        }
    }
}
