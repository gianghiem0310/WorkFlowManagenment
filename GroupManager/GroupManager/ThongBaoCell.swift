//
//  ThongBaoCell.swift
//  GroupManager
//
//  Created by sakurashi on 2/5/1403 AP.
//

import UIKit

class ThongBaoCell: UITableViewCell {

    @IBOutlet weak var hinh: UIImageView!
    @IBOutlet weak var tenDoAn: UILabel!
    @IBOutlet weak var tenNhom: UILabel!
    @IBOutlet weak var Ngay: UILabel!
    @IBOutlet weak var tinhTrang: UILabel!
    @IBOutlet weak var thongBao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
