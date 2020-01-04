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
    
    
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet var labelToday: UINavigationItem!


    
    
    var todoItems: Results<Record>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.table.dataSource = self
        self.table.delegate = self
        
        let realm = try! Realm()
        todoItems = realm.objects(Record.self)
        table.reloadData()
        
        
        labelToday.title = getToday()

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
        self.table.reloadData()
        
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
        self.table.reloadData()
    
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
        self.table.reloadData()
    
    }
    
    @IBAction func urineButton(_ sender: Any) {
        
        let record = Record()
        record.title = "おしっこ"
        record.nowTime = getTime()
        record.buttonImage = UIImage(named: "urine")
        record.save()
        
        //インスタンス取得
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(record)
        }
        self.table.reloadData()
    
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
        self.table.reloadData()
    
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
        self.table.reloadData()
    
    }
    
    
    
//画面が表示される前に実行される処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
//セル数宣言
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let realm = try! Realm()
        let records = realm.objects(Record.self)
        return todoItems.count
    }
    
//セル表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let realm = try! Realm()
        let records = realm.objects(Record.self)
        let object = todoItems[indexPath.row]
        cell.textLabel?.text = object.title
        cell.textLabel?.text = object.nowTime
        cell.imageView?.image = UIImage()
        
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
