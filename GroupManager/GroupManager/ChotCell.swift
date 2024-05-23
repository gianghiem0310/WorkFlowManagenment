//
//  ChotCell.swift
//  GroupManager
//
//  Created by Nguyen Hong Phuc on 4/26/24.
//

import UIKit

class ChotCell: UITableViewCell {
    //Nguyen Gia Nghiem Edit
    
    @IBOutlet weak var titleJob: UILabel!
    @IBOutlet weak var joinAndQuantity: UILabel!
    //End

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
