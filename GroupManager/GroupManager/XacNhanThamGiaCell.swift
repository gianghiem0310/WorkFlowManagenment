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
            case Enum.THAM_GIA_GROUP:
                Enum.xacNhanVaoGroup(notification: noti, closureDuNguoi: self.thongBaoDuNguoi, closureThanhCong: self.thongBaoThanhCong)
            case Enum.THAM_GIA_DEADLINE:
                Enum.xacNhanThamGiaDeadline(notification: noti, closureDuNguoi: self.thongBaoDeadlineDuNguoi, closureThanhCong: self.thongBaoDeadlineThanhCong)
            case Enum.THAM_GIA_JOB:
                Enum.xacNhanThamGiaJob(notification: noti, closureDuNguoi: self.thongBaoJobDuNguoi, closureThanhCong: self.thongBaoJobThanhCong)
            case Enum.XAC_NHAN_COMPLETE:
                Enum.xacNhanHoanThanhCongViec(notification: noti, closureThatBai: self.xacNhanThatBai, closureThanhCong: self.xacNhanThanhCong)
            default:
                Enum.xacNhanVaoGroup(notification: noti, closureDuNguoi: self.thongBaoDuNguoi, closureThanhCong: self.thongBaoThanhCong)
            }
           
                

        }
    }
    func thongBao(view:ThongBaoController, message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        view.present(alert, animated: true, completion: nil)
    }
    func thongBaoThanhCong(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Tham gia nhóm thành công!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }
    func thongBaoDeadlineThanhCong(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Thêm thành viên vào dự án thành công!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }
    func thongBaoDeadlineDuNguoi(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Dự án đã đủ người", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }

    func thongBaoDuNguoi(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Nhóm đã đủ người", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }
    func thongBaoJobThanhCong(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Thêm thành viên vào công việc thành công!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }
    func thongBaoJobDuNguoi(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Công việc đã đủ người", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }
    func xacNhanThanhCong(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Xác nhận hoàn thành!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }
    func xacNhanThatBai(){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: "Xác nhận thất bại!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnHuy(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageNoti.layer.cornerRadius = 10
        content.numberOfLines = 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
