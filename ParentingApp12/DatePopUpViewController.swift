//
//  DatePopUpViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2020/01/20.
//  Copyright © 2020 咲枝友則. All rights reserved.
//

import UIKit

class DatePopUpViewController: UIViewController {
    @IBOutlet var dateLabel: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var saveButton: UIButton!
    var birthdaySelect = Date()
    var birthdayLabel = ""
    var now = Date().addingTimeInterval(0)
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.overrideUserInterfaceStyle = .light
    }
    
    @IBAction func saveDate(_ sender: Any) {
    let backVC = self.presentingViewController as! RegistrationViewController
    let Age = birthdaySelect.timeIntervalSince(datePicker.date)
    let myAge2 = Int(Age)//秒齢
    let myAge3 = Double(myAge2)
        _ = Int(myAge2/60/60/24)//日齢
        _ = Int(myAge3/60/60/24/365.24)//年齢、端数の切り捨て
    let calendar = Calendar(identifier: .gregorian)
    let timeStamp = Date(timeInterval: TimeInterval(myAge3), since: now )
    let elapsedComps = calendar.dateComponents([.year, .month, .day], from: timeStamp, to: now)
    birthdayLabel = String(format: "生後%d年%dヶ月%d日", elapsedComps.year!, elapsedComps.month!, elapsedComps.day!)
       backVC.birthday = self.datePicker.date
       backVC.birthdayLabel1 = birthdayLabel
    let selectDate = self.datePicker.date
        
    self.dismiss(animated: true, completion: nil)
//選択した日付を保存
        defaults.set(birthdayLabel, forKey: "birthdaySetting")
        defaults.set(myAge2, forKey: "myAge2")
        defaults.set(selectDate, forKey: "selectDate")
    }
}
