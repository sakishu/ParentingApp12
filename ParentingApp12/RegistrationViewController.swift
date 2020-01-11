//
//  RegistrationViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2019/12/26.
//  Copyright © 2019 咲枝友則. All rights reserved.
//

import UIKit

protocol FirstDelegate: class {
    func addButtonTapped(text: String)
}

class RegistrationViewController: UIViewController,UITextFieldDelegate{
    
    weak var delegate: FirstDelegate?
    
    @IBOutlet var babyName: UITextField!
    @IBOutlet var sex: UISegmentedControl!
    @IBOutlet var birthday: UISegmentedControl!
    
    var babyInfomation = ""
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        babyName.delegate = self
        
        userDefaults.register(defaults: ["Name": ""])
        
        babyName.text = readData()

    }
    
    func readData() -> String {
        
        let str: String = userDefaults.object(forKey: "Name") as! String
        
        return str
        
    }
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool{

        //(主人公)の内容を①へ代入。
//        testText = workPlaces.text!

//        workPlaces.text = testText

        // 特定のUITextFieldやUITextViewの状態を変更することができる
//        workPlaces.resignFirstResponder()

        //(保存したいデータ)を引数として以下の関数へ
//        saveData(str: testText)

//        return true
//    }
    
    
    //ここの関数内のuserDefaults.setで保存している。
       func saveData(str: String){

           // Keyを指定して保存
           userDefaults.set(str, forKey: "Name")

       }
    
    
    
    @IBAction func sexSelect(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
               case 0: print("男の子")
               case 1: print("女の子")
               case 2: print("性別設定なし")
               default: print("error")
               }
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func add(_ sender: Any) {
        
//        delegate?.addButtonTapped(text: text.text!)
        
      //赤ちゃん情報を取り出す
//        if (UserDefaults.standard.object(forKey: "baby") != nil){
//            babyInfomation = UserDefaults.standard.object(forKey: "baby") as! [String]
//        }
        
//        babyInfomation.append(babyName.text!)
//        UserDefaults.standard.set(babyInfomation, forKey: "baby")
    }
    
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        babyName.resignFirstResponder()
        
//        return true
//    }
}
