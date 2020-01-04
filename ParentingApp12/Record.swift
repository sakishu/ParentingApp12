//
//  Record.swift
//  ParentingApp12
//
//  Created by 咲枝友則 on 2019/12/30.
//  Copyright © 2019 咲枝友則. All rights reserved.
//

import Foundation
import RealmSwift

class Record: Object{
    @objc dynamic var title = ""
    @objc dynamic var nowTime = ""
    @objc dynamic var buttonImage: UIImage? = nil
}
