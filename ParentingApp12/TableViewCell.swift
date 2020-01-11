//
//  TableViewCell.swift
//  Pods-ParentingApp12
//
//  Created by 咲枝友則 on 2020/01/05.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var ButtonImage: UIImageView!
    
    @IBOutlet var TimeLabel: UILabel!
    
    @IBOutlet var ParentLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    func setCell(record: Record) {
//      self.ParentLabel.text = record.title as String
//      self.TimeLabel.text = record.nowTime as String
//        self.ButtonImage.image = record.buttonImage as UIImage?
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(text: String, label: String, image: UIImage) {
        ParentLabel.text = text
        TimeLabel.text = label
        ButtonImage.image = image
    }
    
}
