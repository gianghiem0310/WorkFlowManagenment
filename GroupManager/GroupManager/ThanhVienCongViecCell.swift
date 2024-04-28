//
//  ThanhVienCongViecCell.swift
//  GroupManager
//
//  Created by sakurashi on 2/6/1403 AP.
//

import UIKit

class ThanhVienCongViecCell: UITableViewCell {
    

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var trangThai: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
