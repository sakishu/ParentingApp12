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
    @IBOutlet var birthdarButton: UIButton!
    @IBOutlet var addButton: UIButton!
    var array = [String]()
    var textField = ""
    var sexSelect = UIImage()
    var birthday = Date()
    var birthdayLabel1 = ""
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
        babyName.delegate = self
        sex.selectedSegmentIndex = UISegmentedControl.noSegment
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
            default: sexSelect = UIImage(named: "cherry")!
            let data = sexSelect.pngData()
            defaults.set(data, forKey: "image")
    }
}
    
    @IBAction func birthdayButton(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabBar" {
            if let tabVC = segue.destination as? UITabBarController,
            let navVC = tabVC.viewControllers?.first as? UINavigationController,
            let destVC = navVC.viewControllers.first as? RecordViewController {
                destVC.name = self.babyName.text ?? ""
                destVC.babyImageView = self.sexSelect
                destVC.birthdayLabel2 = birthdayLabel1
                destVC.birthdaySelect = birthday
                //入力した名前を保存
                defaults.set(babyName.text, forKey: "Name")
                textField = babyName.text ?? ""
            }
        }
    }

    @IBAction func add(_ sender: Any) {
    }
    
//キーボード閉じる
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        babyName.resignFirstResponder()
        return true
    }
}


