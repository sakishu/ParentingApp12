//
//  EventViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2020/01/29.
//  Copyright © 2020 咲枝友則. All rights reserved.
//

import UIKit
import RealmSwift
//ディスプレイサイズ取得
let w2 = UIScreen.main.bounds.size.width
let h2 = UIScreen.main.bounds.size.height
//スケジュール内容入力テキスト
let eventText = UITextView(frame: CGRect(x: (w2 - 300) / 2, y: 50, width: 300, height: 200))

//日付フォーム(UIDatePickerを使用)
let y = UIDatePicker(frame: CGRect(x: 0, y: 210, width: w2, height: 300))
//日付表示
let y_text = UILabel(frame: CGRect(x: (w2 - 300) / 2, y: 465, width: 300, height: 20))
class EventViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        
        eventText.delegate = self

            //スケジュール内容入力テキスト設定
        eventText.text = ""
        eventText.layer.borderColor = UIColor.gray.cgColor
        eventText.layer.borderWidth = 1.0
        eventText.layer.cornerRadius = 10.0
        eventText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventText)
        eventText.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        eventText.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        eventText.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        eventText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60).isActive = true
        
        //日付フォーム設定
        y.datePickerMode = UIDatePicker.Mode.date
        y.timeZone = NSTimeZone.local
        y.addTarget(self, action: #selector(picker(_:)), for: .valueChanged)
        y.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(y)
        y.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        y.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        y.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.33).isActive = true
        y.topAnchor.constraint(equalTo: eventText.bottomAnchor, constant: 20).isActive = true
        

        //日付表示設定
        y_text.backgroundColor = .systemBackground
        y_text.textAlignment = .center
        y_text.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(y_text)
        y_text.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        y_text.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        y_text.topAnchor.constraint(equalTo: y.bottomAnchor, constant: 20).isActive = true

        //「保存」ボタン
        let eventInsert = UIButton(frame: CGRect(x: (w2 - 200) / 2, y: 495, width: 200, height: 50))
        eventInsert.setTitle("保存", for: UIControl.State())
        eventInsert.setTitleColor(.blue, for: UIControl.State())
        eventInsert.backgroundColor = .systemBackground
        eventInsert.layer.cornerRadius = 10.0
        eventInsert.layer.borderWidth = 1.0
 //       eventInsert.layer.borderColor = UIColor(red: 1.0, green: 0, blue: 1.0, alpha: 0.2).cgColor
        eventInsert.addTarget(self, action: #selector(saveEvent(_:)), for: .touchUpInside)
        eventInsert.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventInsert)
        eventInsert.topAnchor.constraint(equalTo: y_text.bottomAnchor, constant: 20).isActive = true
        eventInsert.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        eventInsert.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
    
        //「戻る」ボタン
        let backBtn = UIButton(frame: CGRect(x: (w - 200) / 2, y: h - 345, width: 200, height: 30))
        backBtn.setTitle("戻る", for: UIControl.State())
        backBtn.setTitleColor(.blue, for: UIControl.State())
        backBtn.backgroundColor = .systemBackground
        backBtn.layer.cornerRadius = 10.0
//        backBtn.layer.borderColor = UIColor(red: 1.0, green: 0, blue: 1.0, alpha: 0.2).cgColor
        backBtn.layer.borderWidth = 1.0
        backBtn.addTarget(self, action: #selector(onbackClick(_:)), for: .touchUpInside)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backBtn)
        backBtn.topAnchor.constraint(equalTo: eventInsert.bottomAnchor, constant: 20).isActive = true
        backBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        backBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        
        

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        y_text.text = formatter.string(from: y.date)
        view.addSubview(y_text)
        
    }

    //画面遷移(カレンダーページ)
    @objc func onbackClick(_: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    //日付フォーム
    @objc func picker(_ sender:UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        y_text.text = formatter.string(from: sender.date)
        view.addSubview(y_text)
    }

    //DB書き込み処理
    @objc func saveEvent(_ : UIButton){
        print("データ書き込み開始")

            let realm = try! Realm()

            try! realm.write {
                //日付表示の内容とスケジュール入力の内容が書き込まれる。
                let Events = [Event(value: ["date": y_text.text, "event": eventText.text])]
                realm.add(Events)
                print("データ書き込み中")
            }

        print("データ書き込み完了")

        //前のページに戻る
        dismiss(animated: true, completion: nil)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

