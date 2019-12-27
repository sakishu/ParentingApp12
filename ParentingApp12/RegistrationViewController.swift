//
//  RegistrationViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2019/12/26.
//  Copyright © 2019 咲枝友則. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet var babyName: UITextField!
    @IBOutlet var sex: UISegmentedControl!
    @IBOutlet var birthday: UISegmentedControl!
    
    var babyInfomation = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        babyName.delegate = self

    }
    
    @IBAction func add(_ sender: Any) {
        
      //赤ちゃん情報を取り出す
        if (UserDefaults.standard.object(forKey: "baby") != nil){
            babyInfomation = UserDefaults.standard.object(forKey: "baby") as! [String]
        }
        
        babyInfomation.append(babyName.text!)
        UserDefaults.standard.set(babyInfomation, forKey: "baby")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        babyName.resignFirstResponder()
        
        return true
    }
}
