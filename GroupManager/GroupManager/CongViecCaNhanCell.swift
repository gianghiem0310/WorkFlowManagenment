//
//  CongViecCaNhanCell.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/22/24.
//

import UIKit

class CongViecCaNhanCell: UITableViewCell {

    @IBOutlet weak var anhCongViec: UIImageView!
    @IBOutlet weak var tenCongViec: UILabel!
    @IBOutlet weak var nhomCongViec: UILabel!
    @IBOutlet weak var deadline: UILabel!
    @IBOutlet weak var trangThai: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        anhCongViec.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
