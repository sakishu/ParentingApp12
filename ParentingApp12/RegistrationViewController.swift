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
   
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        babyName.delegate = self

    }
    
 
    

    @IBAction func sexSelect(_ sender: UISegmentedControl) {
        switch sex.selectedSegmentIndex{
            case 0: sexSelect = UIImage(named: "babys")!
                    let data = sexSelect.pngData()
                    defaults.set(data, forKey: "image")
            case 1: sexSelect = UIImage(named: "girl")!
                    let data = sexSelect.pngData()
                    defaults.set(data, forKey: "image")
            case 2: sexSelect = UIImage(named: "cherry")!
                    let data = sexSelect.pngData()
                    defaults.set(data, forKey: "image")
            default: print("error")
    }
}
    
    @IBAction func birthdayButton(_ sender: Any) {
        
    
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
        
        print(birthdayLabel1)
        
//入力した名前を保存
        defaults.set(babyName.text, forKey: "Name")
        
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
