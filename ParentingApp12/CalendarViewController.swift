//
//  CalendarViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2020/01/27.
//  Copyright © 2020 咲枝友則. All rights reserved.
//

import UIKit
import FSCalendar
import CalculateCalendarLogic
import RealmSwift

//ディスプレイサイズ取得
let w = UIScreen.main.bounds.size.width
let h = UIScreen.main.bounds.size.height

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //カレンダー処理(スケジュール表示処理)
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){

        labelTitle.text = "スケジュール"
        labelTitle.backgroundColor = UIColor(red: 1.0, green: 0, blue: 1.0, alpha: 0.2)
        view.addSubview(labelTitle)

        //予定がある場合、スケジュールをDBから取得・表示する。
        //無い場合、「スケジュールはありません」と表示。
        labelDate.text = "スケジュールはありません"
        labelDate.textColor = .lightGray
        view.addSubview(labelDate)

        let tmpDate = Calendar(identifier: .gregorian)
        let year = tmpDate.component(.year, from: date)
        let month = tmpDate.component(.month, from: date)
        let day = tmpDate.component(.day, from: date)
        let m = String(format: "%02d", month)
        let d = String(format: "%02d", day)

        let da = "\(year)/\(m)/\(d)"

        //クリックしたら、日付が表示される。
        Date.text = "\(m)/\(d)"
        view.addSubview(Date)

        //スケジュール取得
        let realm = try! Realm()
        var result = realm.objects(Event.self)
        result = result.filter("date = '\(da)'")
        print(result)
        for ev in result {
            if ev.date == da {
                labelDate.text = ev.event
                labelDate.textColor = .black
                view.addSubview(labelDate)
            }
        }
    }
    
    //画面遷移(スケジュール登録ページ)
    @objc func onClick(_: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SecondController = storyboard.instantiateViewController(withIdentifier: "Insert")
        present(SecondController, animated: true, completion: nil)
        
    }
    //スケジュール内容
    let labelDate = UILabel(frame: CGRect(x: 5, y: 580, width: 400, height: 50))
    //「主なスケジュール」の表示
    let labelTitle = UILabel(frame: CGRect(x: 0, y: 530, width: 180, height: 50))
    //カレンダー部分
    let dateView = FSCalendar(frame: CGRect(x: 0, y: 80, width: w, height: 400))
    //日付の表示
    let Date = UILabel(frame: CGRect(x: 5, y: 430, width: 200, height: 100))
    override func viewDidLoad() {
        super.viewDidLoad()
        //カレンダー設定
        self.dateView.dataSource = self
        self.dateView.delegate = self
        self.dateView.appearance.headerDateFormat = "YYYY年MM月"
        self.dateView.calendarWeekdayView.weekdayLabels[0].text = "日"
        self.dateView.calendarWeekdayView.weekdayLabels[1].text = "月"
        self.dateView.calendarWeekdayView.weekdayLabels[2].text = "火"
        self.dateView.calendarWeekdayView.weekdayLabels[3].text = "水"
        self.dateView.calendarWeekdayView.weekdayLabels[4].text = "木"
        self.dateView.calendarWeekdayView.weekdayLabels[5].text = "金"
        self.dateView.calendarWeekdayView.weekdayLabels[6].text = "土"
        self.dateView.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        self.dateView.calendarWeekdayView.weekdayLabels[1].textColor = UIColor.black
        self.dateView.calendarWeekdayView.weekdayLabels[2].textColor = UIColor.black
        self.dateView.calendarWeekdayView.weekdayLabels[3].textColor = UIColor.black
        self.dateView.calendarWeekdayView.weekdayLabels[4].textColor = UIColor.black
        self.dateView.calendarWeekdayView.weekdayLabels[5].textColor = UIColor.black
        self.dateView.calendarWeekdayView.weekdayLabels[6].textColor = UIColor.blue
        self.dateView.today = nil
        self.dateView.tintColor = .red
        self.view.backgroundColor = .white
        dateView.backgroundColor = .white
        view.addSubview(dateView)

        //日付表示設定
        Date.text = ""
        Date.font = UIFont.systemFont(ofSize: 60.0)
        Date.textColor = .black
        view.addSubview(Date)

        //「主なスケジュール」表示設定
        labelTitle.text = ""
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 20.0)
        view.addSubview(labelTitle)

        //スケジュール内容表示設定
        labelDate.text = ""
        labelDate.font = UIFont.systemFont(ofSize: 18.0)
        view.addSubview(labelDate)

        //スケジュール追加ボタン
        let addBtn = UIButton(frame: CGRect(x: w - 110, y: h - 200, width: 60, height: 60))
        addBtn.setTitle("+", for: UIControl.State())
        addBtn.setTitleColor(.white, for: UIControl.State())
        addBtn.backgroundColor = UIColor(red: 1.0, green: 0, blue: 1.0, alpha: 0.2)
        addBtn.layer.cornerRadius = 30.0
        addBtn.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        view.addSubview(addBtn)


    }

    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    // 祝日判定を行い結果を返すメソッド
    func judgeHoliday(_ date : Date) -> Bool {
        //祝日判定用のカレンダークラスのインスタンス
        let tmpCalendar = Calendar(identifier: .gregorian)

        // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)

        let holiday = CalculateCalendarLogic()

        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }

    // date型 -> 年月日をIntで取得
    func getDay(_ date:Date) -> (Int,Int,Int){
        let tmpCalendar = Calendar(identifier: .gregorian)
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        return (year,month,day)
    }

    //曜日判定
    func getWeekIdx(_ date: Date) -> Int{
        let tmpCalendar = Calendar(identifier: .gregorian)
        return tmpCalendar.component(.weekday, from: date)
    }

    // 土日や祝日の日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする
        if self.judgeHoliday(date){
            return UIColor.red
        }

        //土日の判定
        let weekday = self.getWeekIdx(date)
        if weekday == 1 {
            return UIColor.red
        }
        else if weekday == 7 {
            return UIColor.blue
        }

        return nil
    }

}

