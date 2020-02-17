//
//  RecordViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2019/12/28.
//  Copyright © 2019 咲枝友則. All rights reserved.
//

import UIKit
import RealmSwift

class RecordViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {
    
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
    
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: selectedDate)
        let month = tmpDate.component(.month, from: selectedDate)
        let day = tmpDate.component(.day, from: selectedDate)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)
        let da = "\(year)/\(m)/\(d)"
        //スケジュール取得
        todoItems = realm.objects(Record.self).filter("date = '\(da)'").sorted(byKeyPath: "nowTime", ascending: true)

        
        
/*        var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
        let date1 = calendar.startOfDay(for: selectedDate)
        
        let date2 = calendar.date(byAdding: .day, value: 1, to: date1)
        todoItems = realm.objects(Record.self).filter("date >= %@ AND date < %@", date1, date2!)*/
//2020-02-12 07:40:21 +0000 時間表示形式
        
//ライトモード設定
        self.overrideUserInterfaceStyle = .light
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
//日付表示
        labelToday.title = getToday()
        
        birthdayLabel.text = birthdayLabel2
        
        
//realmデータ確認用
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"RecordCell")
        tableView.reloadData()
    }
    

//タップすると表示の日付から−１日
    @IBAction func buttonYesterday(_ sender: Any) {
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

        
 /*       let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: selectedDate)
        let date2 = calendar.date(byAdding: .day, value: 1, to: date1)
        todoItems = realm.objects(Record.self).filter("date >= %@ AND date < %@", date1, date2!)
    print(date1,"date1")
            print(date2!,"date2")*/
        tableView.reloadData()
    }
//タップすると表示の日付から１日
    @IBAction func buttonTomorrow(_ sender: Any) {
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
/*        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: selectedDate)
        let date2 = calendar.date(byAdding: .day, value: 1, to: date1)
        todoItems = realm.objects(Record.self).filter("date >= %@ AND date < %@", date1, date2!)*/
        
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
        //userDefaultsから参照(Data)
                let sexData = defaults.data(forKey: "image")
                //DataをImageに変換
        let babyImageView = UIImage(data: sexData!)
                //入力した誕生日を取得
        birthdayLabel.text = defaults.string(forKey: "birthdaySetting")
        //入力されたニックネームを表示
                babyName.title = defaults.string(forKey: "Name")
                
        //      babyImage.image = babyImageView
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
