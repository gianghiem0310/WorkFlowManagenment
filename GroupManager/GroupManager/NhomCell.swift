//
//  GroupCell.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

class NhomCell: UITableViewCell {

    @IBOutlet weak var anhNhom: UIImageView!
    
    @IBOutlet weak var tenNhom: UILabel!
    
    @IBOutlet weak var soLuong: UILabel!
    
    @IBAction func xemChiTiet(_ sender: UIButton) {
        let storyboard = Enum.STORYBOARD
        
    }
    var data:Group?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        anhNhom.layer.cornerRadius = 15
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
