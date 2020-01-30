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
    static let realm = try! Realm()

    
    @objc dynamic var title = ""
    @objc dynamic var nowTime = ""
    @objc private var _buttonImage: UIImage? = nil
    @objc dynamic var buttonImage: UIImage? {
        set{
            self._buttonImage = newValue
            if let value = newValue {
                self.imageData = value.pngData()
    }
}
    get{
        if let image = self._buttonImage {
            return image
        }
        if let data = self.imageData {
            self._buttonImage = UIImage(data: data)
            return self._buttonImage
        }
        return nil
        }
    }
    @objc dynamic private var imageData: Data? = nil
    
    override static func ignoredProperties() -> [String] {
        return ["buttonImage", "_buttonImage"]
    }
    func save() {
        try! Record.realm.write{
            Record.realm.add(self)
        }
    }

    
}

//extension Data{
    
  //  public func toImage() -> UIImage{
    //    guard  let image = UIImage(data: self) else {
      //      print("PNGデータをイメージに変換できませんでした")
        //    return UIImage()
        //}
        //return image
    //}
    
//}

