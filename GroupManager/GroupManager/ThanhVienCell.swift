//
//  MemberProjectCell.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

class ThanhVienCell: UITableViewCell {

    @IBOutlet weak var avtThanhVien: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avtThanhVien.layer.cornerRadius = avtThanhVien.frame.width/2
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
