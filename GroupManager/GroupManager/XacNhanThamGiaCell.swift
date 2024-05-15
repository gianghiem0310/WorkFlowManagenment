//
//  XacNhanThamGiaNhomCell.swift
//  GroupManager
//
//  Created by Gia Nghiem on 5/7/24.
//

import UIKit
import FirebaseDatabase

class XacNhanThamGiaCell: UITableViewCell {

    var data:Notification?
    var view:ThongBaoController?
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imageNoti: UIImageView!
    @IBOutlet weak var titleGroup: UILabel!
    @IBAction func btnDongY(_ sender: UIButton) {
        if let noti = data,let view = view{
            let database = Enum.DB_REALTIME
            switch noti.type {
            case Enum.XAC_NHAN_COMPLETE:
                database.child(Enum.JOB_MEMBER_TABLE).child("\(noti.idGroup)").child("\(noti.idDeadline)").child("\(noti.idJob)").child("\(noti.idSender)").child("status").setValue(true)
                database.child(Enum.NOTIFICATION_TABLE).child("\(noti.idReceiver)").child("\(noti.idSender)").child("\(noti.id)").removeValue()
                self.thongBao(view: view, message: "Xác nhận làm xong việc!")
            case Enum.THAM_GIA_GROUP:
                var kiemTra = true
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    if kiemTra {
                        database.child(Enum.GROUP_TABLE).child("\(noti.idGroup)").observe(DataEventType.value){
                            snap in
                            if kiemTra{
                                if snap.childrenCount > 0 {
                                    if let child = snap.value as? NSDictionary {
                                        let join = child["join"] as? Int ?? -1
                                        let quantity = child["quantity"] as? Int ?? -1
                                        if join == quantity {
                                            self.thongBao(view:view, message: "Nhóm đã đủ người!")
                                            database.child(Enum.NOTIFICATION_TABLE).child("\(noti.idReceiver)").child("\(noti.idSender)").child("\(noti.id)").removeValue()
                                        }else{
                                           
                                            Enum.xacNhanVaoGroup(notification: noti,join:join)
                                            self.thongBao(view:view, message: "Tham gia nhóm thành công!")
                                            kiemTra = false
                                        }
                                    }
                                }
                            }
                           
                        }
                    }
                }
                
            case Enum.THAM_GIA_DEADLINE:
                database.child(Enum.DEADLINE_TABLE).child("\(noti.idGroup)").child("\(noti.idDeadline)").observe(DataEventType.value){
                    snap in
                    if snap.childrenCount > 0{
                        if let value = snap.value as? NSDictionary{
                            let join = value["join"] as? Int ?? -1
                            let quantity = value["quantity"] as? Int ?? -1
                            if join == quantity {
                                self.thongBao(view:view, message: "Project đã đủ người!")
                            }else{
                                
                                database.child(Enum.DEADLINE_JOIN_TABLE).child("\(noti.idGroup)").child("\(noti.idDeadline)").child("fit").setValue(0)
                                database.child(Enum.DEADLINE_JOIN_TABLE).child("\(noti.idGroup)").child("\(noti.idDeadline)").child("id").setValue(noti.idSender)
                                database.child(Enum.NOTIFICATION_TABLE).child("\(noti.idReceiver)").child("\(noti.idSender)").child("\(noti.id)").removeValue()
                                self.thongBao(view:view, message: "Tham gia project thành công!")
                            }
                        }
                    }
                }
            default:
                database.child(Enum.GROUP_JOIN_TABLE).child("\(noti.idReceiver)").child("\(noti.idGroup)").child("fit").setValue(0)
                database.child(Enum.GROUP_JOIN_TABLE).child("\(noti.idReceiver)").child("\(noti.idGroup)").child("id").setValue(noti.idGroup)
                database.child(Enum.MEMBER_TABLE).child("\(noti.idGroup)").child("\(noti.idReceiver)").child("id").setValue(noti.idReceiver)
                database.child(Enum.NOTIFICATION_TABLE).child("\(noti.idReceiver)").child("\(noti.idSender)").child("\(noti.id)").removeValue()
                self.thongBao(view:view, message: "Tham gia nhóm thành công!")
            }
           
                

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
        imageNoti.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
