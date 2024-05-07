//
//  XacNhanThamGiaNhomCell.swift
//  GroupManager
//
//  Created by Gia Nghiem on 5/7/24.
//

import UIKit
import FirebaseDatabase

class XacNhanThamGiaNhomCell: UITableViewCell {

    var confirm:Notification?
    var view:ThongBaoController?
    @IBOutlet weak var imageNoti: UIImageView!
    @IBOutlet weak var titleGroup: UILabel!
    @IBAction func btnDongY(_ sender: UIButton) {
        if let noti = confirm,let view = view{
            let database = Enum.DB_REALTIME
            database.child(Enum.GROUP_JOIN_TABLE).child("\(noti.idReceiver)").child("\(noti.idGroup)").child("id").setValue(noti.idGroup)
            database.child(Enum.MEMBER_TABLE).child("\(noti.idGroup)").child("\(noti.idReceiver)").child("id").setValue(noti.idReceiver)
            database.child(Enum.NOTIFICATION_TABLE).child("\(noti.idReceiver)").child("\(noti.idSender)").child("\(noti.id)").removeValue()
            self.thongBao(view:view, message: "Tham gia nhóm thành công!")
        }
    }
    func thongBao(view:ThongBaoController, message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        view.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnHuy(_ sender: UIButton) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
