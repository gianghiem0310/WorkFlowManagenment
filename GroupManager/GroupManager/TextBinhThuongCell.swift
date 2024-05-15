//
//  TextBinhThuongCell.swift
//  GroupManager
//
//  Created by Gia Nghiem on 5/7/24.
//

import UIKit
import FirebaseDatabase
class TextBinhThuongCell: UITableViewCell {

    var data:Notification?
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageNoti: UIImageView!
    @IBOutlet weak var titleNoti: UILabel!
    @IBOutlet weak var contentNoti: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageNoti.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
