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
    let record = Record()
    
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

    var selectedDate = Date().addingTimeInterval(32400)
    
    let defaults = UserDefaults.standard
    
    let sexImage: UIImage? = nil
    
    var now = Date().addingTimeInterval(0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//ライトモード設定
        self.overrideUserInterfaceStyle = .light
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let realm = try! Realm()
        todoItems = realm.objects(Record.self)
        tableView.reloadData()
//日付表示
        labelToday.title = getToday()
        
        birthdayLabel.text = birthdayLabel2
        
//realmデータ確認用
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"RecordCell")
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
        
        self.tableView.reloadData()
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
        
        self.tableView.reloadData()
    }
//以下育児状況記録用のボタン
    @IBAction func wakeUpButton(_ sender: Any) {
        let record = Record()
        record.date = String(describing:selectedDate)
        record.title = "起きる"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "smile")
        record.save()
        self.tableView.reloadData()
    }
    
    @IBAction func sleepButton(_ sender: Any) {
     

        let record = Record()
        record.date = String(describing:selectedDate)
        record.title = "寝る"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "sleep")
        record.save()
        self.tableView.reloadData()
    }
    
    @IBAction func peepButton(_ sender: Any) {
        
        let record = Record()
        record.date = String(describing:selectedDate)
        record.title = "うんち"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "peep")
        record.save()
        self.tableView.reloadData()
    }
    
    @IBAction func urineButton(_ sender: Any) {
        
        let record = Record()
        record.date = String(describing:selectedDate)
        record.title = "おしっこ"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "diapers")
        record.save()
        self.tableView.reloadData()
    }
    
    @IBAction func milkButton(_ sender: Any) {
        
        let record = Record()
        record.date = String(describing:selectedDate)
        record.title = "ミルク"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "milk")
        record.save()
        self.tableView.reloadData()
    }
    
    @IBAction func feedButton(_ sender: Any) {
        
        let record = Record()
        record.date = String(describing:selectedDate)
        record.title = "授乳"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "breastfeed")
        record.save()
        self.tableView.reloadData()
    }
    
//画面が表示される前に実行される処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //userDefaultsから参照(Data)
                let sexData = defaults.data(forKey: "image")
                //DataをImageに変換
                let sexImage = UIImage(data: sexData!)

                //入力した誕生日を取得
        birthdayLabel.text = defaults.string(forKey: "birthdaySetting")
            
        //入力されたニックネームを表示
                babyName.title = defaults.string(forKey: "Name")
                
        //      babyImage.image = babyImageView
        //      取得した性別画像を表示
                babyImage.image = sexImage
        
        tableView.reloadData()
        
       

    }
    
//セル数宣言
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        _ = try! Realm()
        return todoItems.count
    }
    
//セル表示
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! TableViewCell
        
        let realm = try! Realm()
        let object = todoItems[indexPath.row]
        var result = realm.objects(Record.self)

        result = result.filter("date = '\(String(describing: selectedDate))'")

        for rd in result {

            if rd.date == String(describing: selectedDate) {
             record.title = rd.title

             record.nowTime = rd.nowTime

             record.buttonImage = rd.buttonImage
                print(rd.date)
            }
        }
        
        cell.bindData(text: object.title, label: object.nowTime, image: object.buttonImage!)
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
    
    func getYesterday() -> String{
        
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        let now = Date().addingTimeInterval(0)

        let yesterday = Date(timeInterval: 60 * 60 * -24, since: now)
        return f.string(from: yesterday)
    }
        
    
    func getTomorrow() -> String{
        
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        _ = Date()
        let tomorrow = Date(timeIntervalSinceNow: 60 * 60 * 24)
        return f.string(from: tomorrow)
    }
}
