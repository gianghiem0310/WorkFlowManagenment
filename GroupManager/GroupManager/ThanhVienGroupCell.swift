//
//  ThanhVienGroupCell.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/30/24.
//

import UIKit

class ThanhVienGroupCell: UITableViewCell {

    @IBOutlet weak var avtThanhVien: UIImageView!
    @IBOutlet weak var tenThanhVien: UILabel!
    @IBOutlet weak var diemFit: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avtThanhVien.layer.cornerRadius = avtThanhVien.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
