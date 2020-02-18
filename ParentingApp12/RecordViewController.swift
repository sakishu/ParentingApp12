//
//  RecordViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2019/12/28.
//  Copyright © 2019 咲枝友則. All rights reserved.
//

import UIKit
import RealmSwift

class RecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    lazy var realm = try! Realm()
    
    @IBOutlet var tableView: UITableView!
    
//日付表示用タイトル
    @IBOutlet var labelToday: UINavigationItem!
//赤ちゃんの名前を表示するタイトル
    @IBOutlet var babyName: UINavigationItem!
//年齢表示ラベル
    @IBOutlet var birthdayLabel: UILabel!
//前日ボタン
    @IBOutlet var yesterdayLabel: UIBarButtonItem!
//翌日ボタン
    @IBOutlet var tomorrowLabel: UIBarButtonItem!
    
    @IBOutlet var babyImage: UIImageView!
    
//RegistrationViewControllerで入力されたニックネームを受け取る変数
    var name = ""
//選択画像受取
    var babyImageView:UIImage = UIImage()
    
    var birthdayLabel2 = ""
    
    var babyBirthday = Date()
    
    var todoItems: Results<Record>!

    var selectedDate = Date()
    
    let defaults = UserDefaults.standard
    
    let sexImage: UIImage? = UIImage()
    
    var now = Date().addingTimeInterval(0)
    
    //誕生日受け取り変数
    var birthdaySelect = Date()
    var now1 = Date().addingTimeInterval(0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let AgeData:Int = defaults.integer(forKey: "myAge2")
        let selectDate = defaults.object(forKey: "selectDate") as? Date
        let myAge3 = Double(AgeData)
        let myAge4 = Int(AgeData/60/60/24)//日齢
          _ = Int(myAge3/60/60/24/365.24)//年齢、端数の切り捨て
        let calendar = Calendar(identifier: .gregorian)
        let timeStamp = Date(timeInterval: TimeInterval(myAge4), since: selectDate ?? Date())
        print(birthdaySelect)
        let elapsedComps = calendar.dateComponents([.year, .month, .day], from: timeStamp, to: now1)
        birthdayLabel.text = String(format: "生後%d年%dヶ月%d日", elapsedComps.year!, elapsedComps.month!, elapsedComps.day!)
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        
        //スケジュール取得
        todoItems = realm.objects(Record.self).filter("date = '\(da)'").sorted(byKeyPath: "nowTime", ascending: true)

//2020-02-12 07:40:21 +0000 時間表示形式
        
//ライトモード設定
        self.overrideUserInterfaceStyle = .light
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
//日付表示
        labelToday.title = getToday()
//        birthdayLabel.text = birthdayLabel2
        
//realmデータ確認用
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"RecordCell")
        tableView.reloadData()
    }
    

//タップすると表示の日付から−１日
    @IBAction func buttonYesterday(_ sender: Any) {
        let AgeData:Int = defaults.integer(forKey: "myAge2")
        let selectDate = defaults.object(forKey: "selectDate") as? Date
        let myAge3 = Double(AgeData)
        let myAge4 = Int(AgeData/60/60/24)//日齢
          _ = Int(myAge3/60/60/24/365.24)//年齢、端数の切り捨て
        let calendar = Calendar(identifier: .gregorian)
        let timeStamp = Date(timeInterval: TimeInterval(myAge4), since: selectDate ?? Date())
        now1 = Date(timeInterval: 60 * 60 * -24, since: now1)
        let elapsedComps = calendar.dateComponents([.year, .month, .day], from: timeStamp, to: now1)
        birthdayLabel.text = String(format: "生後%d年%dヶ月%d日", elapsedComps.year!, elapsedComps.month!, elapsedComps.day!)
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        selectedDate = Date(timeInterval: 60 * 60 * -24, since: selectedDate)
        now = Date(timeInterval: 60 * 60 * -24, since: now)
        labelToday.title = f.string(from: now)
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        //スケジュール取得
        todoItems = realm.objects(Record.self).filter("date = '\(da)'").sorted(byKeyPath: "nowTime", ascending: true)
        tableView.reloadData()
    }
//タップすると表示の日付から１日
    @IBAction func buttonTomorrow(_ sender: Any) {
        let AgeData:Int = defaults.integer(forKey: "myAge2")
        let selectDate = defaults.object(forKey: "selectDate") as? Date
        let myAge3 = Double(AgeData)
        let myAge4 = Int(AgeData/60/60/24)//日齢
          _ = Int(myAge3/60/60/24/365.24)//年齢、端数の切り捨て
        let calendar = Calendar(identifier: .gregorian)
        let timeStamp = Date(timeInterval: TimeInterval(myAge4), since: selectDate ?? Date())
        now1 = Date(timeInterval: 60 * 60 * 24, since: now1)
        let elapsedComps = calendar.dateComponents([.year, .month, .day], from: timeStamp, to: now1)
        birthdayLabel.text = String(format: "生後%d年%dヶ月%d日", elapsedComps.year!, elapsedComps.month!, elapsedComps.day!)
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        selectedDate = Date(timeInterval: 60 * 60 * 24, since: selectedDate)
        now = Date(timeInterval: 60 * 60 * 24, since: now)
        labelToday.title = f.string(from: now)
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        todoItems = realm.objects(Record.self).filter("date = '\(da)'").sorted(byKeyPath: "nowTime", ascending: true)
        tableView.reloadData()
    }
//以下育児状況記録用のボタン
    @IBAction func wakeUpButton(_ sender: Any) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        let record = Record()
        record.date = da
        record.title = "起きる"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "smile")
        record.save()
        tableView.reloadData()
    }
    
    @IBAction func sleepButton(_ sender: Any) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        let record = Record()
        record.date = da
        record.title = "寝る"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "sleep")
        record.save()
        tableView.reloadData()
    }
    
    @IBAction func peepButton(_ sender: Any) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        let record = Record()
        record.date = da
        record.title = "うんち"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "peep")
        record.save()
        tableView.reloadData()
    }
    
    @IBAction func urineButton(_ sender: Any) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        let record = Record()
        record.date = da
        record.title = "おしっこ"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "diapers")
        record.save()
        tableView.reloadData()
    }
    
    @IBAction func milkButton(_ sender: Any) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        let record = Record()
        record.date = da
        record.title = "ミルク"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "milk")
        record.save()
        tableView.reloadData()
    }
    
    @IBAction func feedButton(_ sender: Any) {
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        let record = Record()
        record.date = da
        record.title = "授乳"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "breastfeed")
        record.save()
        tableView.reloadData()
    }
    
//画面が表示される前に実行される処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let AgeData:Int = defaults.integer(forKey: "myAge2")
        let selectDate = defaults.object(forKey: "selectDate") as? Date
        let myAge3 = Double(AgeData)
        let myAge4 = Int(AgeData/60/60/24)//日齢
          _ = Int(myAge3/60/60/24/365.24)//年齢、端数の切り捨て
        let calendar = Calendar(identifier: .gregorian)
        let timeStamp = Date(timeInterval: TimeInterval(myAge4), since: selectDate ?? Date())
        print(birthdaySelect)
        let elapsedComps = calendar.dateComponents([.year, .month, .day], from: timeStamp, to: now1)
        birthdayLabel.text = String(format: "生後%d年%dヶ月%d日", elapsedComps.year!, elapsedComps.month!, elapsedComps.day!)
        //userDefaultsから参照(Data)
                let sexData = defaults.data(forKey: "image")
                //DataをImageに変換
        let babyImageView = UIImage(data: sexData!)
                //入力した誕生日を取得
//        birthdayLabel.text = defaults.string(forKey: "birthdaySetting")
        //入力されたニックネームを表示
                babyName.title = defaults.string(forKey: "Name")
        //      取得した性別画像を表示
                babyImage.image = babyImageView
        
      let tmpDate = Calendar(identifier: .gregorian)
      let year = tmpDate.component(.year, from: selectedDate)
      let month = tmpDate.component(.month, from: selectedDate)
      let day = tmpDate.component(.day, from: selectedDate)
      let m = String(format: "%02d", month)
      let d = String(format: "%02d", day)
      let da = "\(year)/\(m)/\(d)"
      //スケジュール取得
        todoItems = realm.objects(Record.self).filter("date = '\(da)'").sorted(byKeyPath: "nowTime", ascending: true)
        tableView.reloadData()
    }
    
//セル数宣言
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
//セル表示
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! TableViewCell
            
        let object = todoItems[indexPath.row]
            cell.ParentLabel.text = object.title
            cell.TimeLabel.text = object.nowTime
            cell.ButtonImage.image = object.buttonImage!
     //        cell.bindData(text: object.title, label: object.nowTime, image: object.buttonImage!)
        return cell
             }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }


    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            if let object = todoItems?[indexPath.row] {
            
            tableView.reloadData()
            let realm = try! Realm()
            try! realm.write{
                realm.delete(object)
                }
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        return
    }
    
    
    func deleteTodo(Index: Int){
        let realm = try! Realm()
        try! realm.write{
            realm.delete(todoItems[Index])
        }
        
    }
    
//現時刻取得
    func getToday() -> String{
        
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        let now = Date()
        return f.string(from: now)
    }
    
    func getTime() -> String{
        
        let f = DateFormatter()
        f.dateStyle = .none
        f.timeStyle = .short
        f.locale = Locale(identifier: "ja_JP")
        let now = Date()
        return f.string(from: now)
    }
}
