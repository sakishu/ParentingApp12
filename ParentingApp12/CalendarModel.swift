//
//  CalendarModel.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2020/01/27.
//  Copyright © 2020 咲枝友則. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {

    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""

}
