//
//  ThanhVienCongViecCell.swift
//  GroupManager
//
//  Created by sakurashi on 2/6/1403 AP.
//

import UIKit

class ThanhVienCongViecCell: UITableViewCell {
    
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var trangThai: UILabel!
    @IBOutlet weak var thongBao: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageAvatar.layer.cornerRadius = self.imageAvatar.frame.width / 2
        self.imageAvatar.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
