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
    
    
    @IBOutlet var babyNameLabel: UINavigationItem!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var labelToday: UINavigationItem!

    @IBOutlet var yesterdayLabel: UIBarButtonItem!
    
    @IBOutlet var tomorrowLabel: UIBarButtonItem!
    
    var todoItems: Results<Record>!
    
    var now = Date().addingTimeInterval(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let realm = try! Realm()
        todoItems = realm.objects(Record.self)
        tableView.reloadData()
            
        labelToday.title = getToday()

        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier:"RecordCell")
    
    }
    
    @IBAction func buttonYesterday(_ sender: Any) {
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")

        now = Date(timeInterval: 60 * 60 * -24, since: now)
        
        labelToday.title = f.string(from: now)
        
        
    }
    
    @IBAction func buttonTomorrow(_ sender: Any) {
        let f = DateFormatter()
        f.dateStyle = .full
        f.timeStyle = .none
        f.locale = Locale(identifier: "ja_JP")
        
        now = Date(timeInterval: 60 * 60 * 24, since: now)
        
        labelToday.title = f.string(from: now)
    }
    
    
    @IBAction func wakeUpButton(_ sender: Any) {
        
        let record = Record()
        record.title = "起きる"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "smile")
        record.save()
        
        //インスタンス取得
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        self.tableView.reloadData()
        
    }
    
    @IBAction func sleepButton(_ sender: Any) {
        
        let record = Record()
        record.title = "寝る"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "sleep")
        record.save()
        
        //インスタンス取得
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        self.tableView.reloadData()
    
    }
    
    @IBAction func peepButton(_ sender: Any) {
        
        let record = Record()
        record.title = "うんち"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "peep")
        record.save()
        
        //インスタンス取得
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        self.tableView.reloadData()
    
    }
    
    @IBAction func urineButton(_ sender: Any) {
        
        let record = Record()
        record.title = "おしっこ"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "diapers")
        record.save()
        
        //インスタンス取得
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        self.tableView.reloadData()
    
    }
    
    @IBAction func milkButton(_ sender: Any) {
        
        let record = Record()
        record.title = "ミルク"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "milk")
        record.save()
        
        //インスタンス取得
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        self.tableView.reloadData()
    
    }
    
    @IBAction func feedButton(_ sender: Any) {
        
        let record = Record()
        record.title = "授乳"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "breastfeed")
        record.save()
        
        //インスタンス取得
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        self.tableView.reloadData()
    
    }
    
    
    
//画面が表示される前に実行される処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

//セル数宣言
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let realm = try! Realm()
        let records = realm.objects(Record.self)
        return todoItems.count
    }
    
    
//セル表示
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath) as! TableViewCell
        
        let realm = try! Realm()
        let records = realm.objects(Record.self)
        let object = todoItems[indexPath.row]
        cell.bindData(text: object.title, label: object.nowTime, image: object.buttonImage!)

//        cell.setCell(record: records[indexPath.row])
        
        return cell
        }
    
  
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
  
    
    
    func tableView(_ tableView: UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let realm = try! Realm()
            let records = realm.objects(Record.self)
            let object = todoItems[indexPath.row]
            
            try! realm.write{
                realm.delete(records)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        var now = Date().addingTimeInterval(0)

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
    
   func kinou() -> String{

    var calendar = Calendar.current
    let f = DateFormatter()
    f.dateStyle = .full
    f.timeStyle = .none
    f.locale = Locale(identifier: "ja_JP")
    _ = Date()
    let date = Date()

    // 昨日
    let yesterday = calendar.date(byAdding: .day, value: -1, to: calendar.startOfDay(for: date))
        
        return f.string(from: yesterday!)
    }

}
