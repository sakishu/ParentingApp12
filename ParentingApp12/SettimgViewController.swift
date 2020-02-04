//
//  SettimgViewController.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2020/01/27.
//  Copyright © 2020 咲枝友則. All rights reserved.
//

import UIKit

class SettimgViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "cell", for:indexPath as IndexPath)
        
        cell.textLabel!.text = "あいうえお"
        return cell
    }
    
    func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        print("セルをタップしました")
    }
    
}
