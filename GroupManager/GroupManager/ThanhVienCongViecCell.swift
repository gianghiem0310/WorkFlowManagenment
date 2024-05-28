//
//  ThanhVienCongViecCell.swift
//  GroupManager
//
//  Created by sakurashi on 2/6/1403 AP.
//

import UIKit
import FirebaseDatabase
class ThanhVienCongViecCell: UITableViewCell {
    
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var trangThai: UILabel!
    var idCaptain:Int?
    var idUser = -1
    var profile:Profile?
    var titleJob:String?
    var view:FragmentThanhVienCongViecController?
    @IBAction func nhacNho(_ sender: UIButton) {
        if let idCaptain = idCaptain,let profile = profile,let titleJob = titleJob {
            if idCaptain != idUser{
                thongBao(message: "Chức năng chỉ dành cho nhóm trưởng!")
            }else{
                if idCaptain == profile.idAccount{
                    thongBao(message: "Hãy dùng chức năng cho thành viên!")
                }else{
                    Enum.nhacNho(idReceiver: profile.idAccount, idCaptain: idCaptain, titleJob: titleJob)
                    thongBao(message: "Đã nhắc thành viên thực hiện công việc!")
                }
              
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageAvatar.layer.cornerRadius = self.imageAvatar.frame.width / 2
        self.imageAvatar.layer.masksToBounds = true
        getDataUser()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func getDataUser(){
        idUser = UserDefaults.standard.integer(forKey: Enum.ID_USER)
    }
    func thongBao(message: String){
        if let view = view{
            let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            view.present(alert, animated: true, completion: nil)
        }
        
    }
    

}
