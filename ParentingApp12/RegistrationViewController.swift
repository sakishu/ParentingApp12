//
//  RegistrationViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2019/12/26.
//  Copyright © 2019 咲枝友則. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,UITextFieldDelegate{
    
    var array = [String]()
    
    @IBOutlet var babyName: UITextField!
    @IBOutlet var sex: UISegmentedControl!
    @IBOutlet var birthdarButton: UIButton!
   
    var textField = ""
    var sexSelect = UIImage()
    var birthday = Date()
    var birthdayLabel1 = ""
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        
        babyName.delegate = self

    }
    
 
    

    @IBAction func sexSelect(_ sender: UISegmentedControl) {
        switch sex.selectedSegmentIndex{
        case 0: sexSelect = UIImage(named: "babys")!
               case 1: sexSelect = UIImage(named: "girl")!
               case 2: print("性別設定なし")
               default: print("error")
               }
    }
    
    @IBAction func birthdayButton(_ sender: Any) {
        
        UserDefaults.standard.set(babyName.text, forKey: "Name")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabBar" {
            if let tabVC = segue.destination as? UITabBarController,
                let navVC = tabVC.viewControllers?.first as? UINavigationController,
                let destVC = navVC.viewControllers.first as? RecordViewController {
                destVC.name = self.babyName.text!
                destVC.babyImageView = self.sexSelect
                destVC.birthdayLabel2 = birthdayLabel1
                
            }
        }
    }
    
    @IBAction func add(_ sender: Any) {
        
        self.performSegue(withIdentifier: "tabBar", sender: self)
    
        textField = babyName.text!

        UserDefaults.standard.set(textField, forKey: "name")
        
        print(birthdayLabel1)

    }

    
//キーボード閉じる
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        babyName.resignFirstResponder()
        
        return true
    }
}




//*let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
//*tabBarController.selectedIndex = 0 // 1: 2個目のview, 2: 3個目のview
//*self.navigationController?.pushViewController(tabBarController, animated: true)
