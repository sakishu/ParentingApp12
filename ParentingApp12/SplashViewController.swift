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

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if UserDefaults.standard.string(forKey: "Name") == nil{
            performSegue(withIdentifier: "login", sender: nil)
        }else{
            performSegue(withIdentifier: "tabBarController", sender: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
