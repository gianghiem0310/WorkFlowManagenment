//
//  ProjectController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class DuAnController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    
    var idUser = 15
    @IBAction func tool(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        
        if let group = self.group{
            if idUser == group.captain{
                actionSheet.addAction(UIAlertAction(title: "Thêm thành viên", style: .default, handler:{
                    action in
                    self.formAdd()
                }))
                actionSheet.addAction(UIAlertAction(title: "Tạo dự án", style: .default, handler:{
                    action in
                    let storyboard = Enum.STORYBOARD
                    if let des = storyboard.instantiateViewController(identifier: "taoDuAn") as? TaoDuAnController{
                        let navigation = UINavigationController(rootViewController: des)
                         navigation.modalPresentationStyle = .fullScreen
                         self.present(navigation, animated: true, completion: nil)
                    }
                    
                }))
            }
        }
        actionSheet.addAction(UIAlertAction(title: "Rời nhóm", style: .destructive, handler:{
            action in
            if let group = self.group {
                if group.captain == self.idUser {
                    self.thongBao(message: "Chức năng dành cho thành viên bình thường!")
                }
                else{
                    let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn muốn rời nhóm?", preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
                    let confirm = UIAlertAction(title: "Chắc chắn", style: .destructive){_ in
                        
//                        self.outGroup(idGroup: group.id)
                        Enum.roiGroup(idReceiver: group.captain, idSender: self.idUser, content: "1 đã rời nhóm", idGroup: group.id,closure: self.outGroup)
                        
                        
                    }
                    alert.addAction(cancel)
                    alert.addAction(confirm)
                    self.present(alert, animated: true, completion: nil)
                }
                  
                
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .destructive, handler:nil))
        present(actionSheet, animated: true, completion: nil)
    }
    func formAdd() {
        let alert = UIAlertController(title: "Thêm thành viên", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Nhập id"
            textField.borderStyle = .line
            textField.delegate = self
        })
        let cancel = UIAlertAction(title: "Huỷ", style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "Đồng ý", style: .default, handler: {
            action in
            self.trangThaiKiemTra = true
            
            
            if self.trangThaiKiemTra == true {
                if let alert = alert.textFields {
                    if let textF = alert.first{
                        if let value = textF.text, !value.isEmpty{
                            if let idReceiver = Int(value){
                            let database = Enum.DB_REALTIME
                                database.child(Enum.PROFILE_TABLE).child("\(idReceiver)").observe(DataEventType.value){
                                snapshot in
                                if snapshot.childrenCount > 0,self.trangThaiKiemTra == true {
                                    if let child = snapshot.value as? NSDictionary{
                                        if let group = self.group,group.captain == self.idUser{
                                            let content = "Nhóm trưởng mời bạn vào nhóm \(group.title)"
                                            let type = Enum.THAM_GIA_GROUP
                                            let date = Enum.getCurrentDateDDMMYYYY()
                                            
                                            if self.trangThaiKiemTra == true {
                                                database.child(Enum.NOTIFICATION_TABLE).child("\(idReceiver)").child("\(self.idUser)").observe(DataEventType.value){
                                                    snapshot in
                                                    if self.trangThaiKiemTra == true{
                                                        let newNotification = Notification(id:Int(snapshot.childrenCount),idSender: group.captain, idReceiver: idReceiver, content: content, type: type, idGroup: group.id, idDeadline: -1, idJob: -1, date: date)

                                                        Enum.guiLoiMoiThamGiaGroup(notification: newNotification)
                                                        self.trangThaiKiemTra = false
                                                        self.thongBao(message: "Gửi lời mời thành công!")
                                                        textF.text = ""
                                                     
                                                        
                                                    }
                                                   
                                                }
//
                                             
                                            }
                                        }
                                        
                                  
                                      
                                    }
                                }else{
                                    self.thongBao(message: "Id không tồn tại!")
                                    self.trangThaiKiemTra = false
                                }
                               
                            }
                          
                            }else{
                                self.thongBao(message: "Id phải là số")
                                textF.text = ""
                            }
                        }else{
                            self.thongBao(message: "Hãy nhập email!")
                        }
                        
                    }
                }
                
            }
        })
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            choose = true
            if let group = group{
                getDataForTable(idGroup: group.id)
            }
            tableView.reloadData()
        case 1:
            choose = false
            if let group = group{
                getDataForTable(idGroup: group.id)
            }
            tableView.reloadData()
        default:
            choose = true
            tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if choose {
            return mangProject.count
        }
        return mangMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if choose {
            let identifier = "projectCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? DuAnCell else{
                return UITableViewCell()
            }
            let data = mangProject[indexPath.row]
            cell.quantity.text = String(data.quantity)
            cell.title.text = data.deadline
            return cell
        }
        else{
            let identifier = "memberCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? ThanhVienGroupCell else{
                return UITableViewCell()
            }
            let data = mangMember[indexPath.row]
            Enum.setImageFromURL(urlString: data.avatar, imageView: cell.avtThanhVien)
            cell.tenThanhVien.text = data.name
            cell.diemFit.text = "\(data.fit) fit"
            return cell
        }
       
       
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if choose {
            let editAction = UITableViewRowAction(style: .normal, title: "Edit"){action,indexPath in
                if self.choose{
                    
                     let storyboard = Enum.STORYBOARD
                     if let des = storyboard.instantiateViewController(identifier: "taoDuAn") as? TaoDuAnController{
                         let navigation = UINavigationController(rootViewController: des)
                          navigation.modalPresentationStyle = .fullScreen
                        des.title = "Sửa dự án"
                          self.present(navigation, animated: true, completion: nil)
                     }
                }
             
              
                
            }
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
                if self.choose {
                    
                    self.mangProject.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
              
            }
            return [editAction,deleteAction]
        }else{
            
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
                if self.choose == false {
                    let data = self.mangMember[indexPath.row]
                    if let group = self.group{
                        if group.captain == self.idUser{
                            if data.idAccount == group.captain {
                                self.thongBao(message: "Không thể xoá nhóm trưởng!")
                            }else{
                                let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn muốn xoá thành viên \(data.name)?", preferredStyle: .alert)
                                let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
                                let confirm = UIAlertAction(title: "Chắc chắn", style: .destructive){_ in
                                    
                                    self.removeMember(idGroup: group.id, idMember: data.idAccount,group: group)
                                    self.mangMember.remove(at: indexPath.row)
                                    tableView.deleteRows(at: [indexPath], with: .fade)
                                    self.thongBao(message: "Đã xoá \(data.name) ra khỏi nhóm!")
                                    
                                }
                                alert.addAction(cancel)
                                alert.addAction(confirm)
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                        }else{
                            self.thongBao(message: "Bạn không phải là nhóm trưởng!")
                        }
                    }
                    
                   
                }
              
            }
            return [deleteAction]
        }
       
    }
    func outGroup(){
//        let database = Enum.DB_REALTIME
//        database.child(Enum.GROUP_JOIN_TABLE).child("\(idUser)").child("\(idGroup)").removeValue()
//        database.child(Enum.MEMBER_TABLE).child("\(idGroup)").child("\(idUser)").removeValue()
        dismiss(animated: true, completion: nil)
    }
    func removeMember(idGroup:Int,idMember:Int,group:Group){
        let database = Enum.DB_REALTIME
        self.trangThaiKiemTra = true
                database.child(Enum.GROUP_JOIN_TABLE).child("\(idMember)").child("\(idGroup)").removeValue()
                database.child(Enum.MEMBER_TABLE).child("\(idGroup)").child("\(idMember)").removeValue()
                if self.trangThaiKiemTra == true {
                    var idNewNoti = 0
                    database.child(Enum.NOTIFICATION_TABLE).child("\(idMember)").child("\(self.idUser)").observe(DataEventType.value){
                        snapshot in
                        if self.trangThaiKiemTra == true{
                            let content = "Bạn bị xoá khỏi nhóm!"
                            let date = Enum.getCurrentDateDDMMYYYY()
                            let newNotification = Notification(id:Int(snapshot.childrenCount),idSender: group.captain, idReceiver: idMember, content: content, type: Enum.BI_XOA_KHOI_GROUP, idGroup: group.id, idDeadline: -1, idJob: -1, date: date)
                            Enum.xoaThanhVienGroup(notification: newNotification)
                            
                            self.trangThaiKiemTra = false
                        }
                        self.trangThaiKiemTra = false
                    }
                }
            
        
        
    }
    

    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    var choose = true
    var trangThaiKiemTra = false
    var mangProject:[Deadline] = []
    var mangMember:[Profile] = []
    var group:Group?
   
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let group = group{
            if group.image != "NULL"{
                Enum.setImageFromURL(urlString: group.image, imageView: imageView)
            }
            title = group.title
            getDataForTable(idGroup: group.id)
        }
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func getDataForTable(idGroup: Int) {
        mangProject.removeAll()
        tableView.reloadData()
        let database = Enum.DB_REALTIME
        if choose {
            database.child(Enum.DEADLINE_TABLE).child("\(idGroup)").observe(DataEventType.value){
                snapshot in
                self.mangMember.removeAll()
                self.mangProject.removeAll()
                self.tableView.reloadData()
                if snapshot.childrenCount > 0{
                    for child in snapshot.children{
                        if let childSnap = child as? DataSnapshot {
                            if let object = childSnap.value as? NSDictionary{
                                let id = object["id"] as? Int ?? -1
                                let idGroup = object["idGroup"] as? Int ?? -1
                                let deadline = object["deadline"] as? String ?? ""
                                let quantity = object["quantity"] as? Int ?? -1
                                let status = object["status"] as? Bool ?? true
                                let join = object["join"] as? Int ?? -1
                                let value = Deadline(id: id, idGroup: idGroup, deadline: deadline, quantity: quantity, status: status,join: join)
                                self.mangProject.append(value)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        } else {
            database.child(Enum.MEMBER_TABLE).child("\(idGroup)").observe(DataEventType.value){
                snapshot in
              
                self.mangMember.removeAll()
                self.mangProject.removeAll()
                self.tableView.reloadData()
                if snapshot.childrenCount > 0{
                    for child in snapshot.children{
                        if let childSnap = child as? DataSnapshot{
                            if let value = childSnap.value as? NSDictionary{
                                let id = value["id"] as? Int ?? -1
                                if id != -1 {
                                    database.child(Enum.PROFILE_TABLE).child("\(id)").observe(DataEventType.value){
                                        (snapshot) in
                                        if let object = snapshot.value as? NSDictionary{
                                            let idAccount = object["idAccount"] as? Int ?? -1
                                            let avatar = object["avatar"] as? String ?? ""
                                            let name = object["name"] as? String ?? ""
                                            let phone = object["phone"] as? String ?? ""
                                            let email = object["email"] as? String ?? ""
                                            let fit = object["fit"] as? Int ?? -1
                                            let profile = Profile(idAccount: idAccount, avatar: avatar, name: name, phone: phone, email: email, fit: fit)
                                            self.mangMember.append(profile)
                                            self.tableView.reloadData()
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if choose {
            let storyboard = Enum.STORYBOARD
            if let view = storyboard.instantiateViewController(identifier: "manHinhDanhSachCongViec") as? DanhSachCongViecController{
                view.deadline = mangProject[indexPath.row]
                if let gr = group{
                    view.idCaptain = gr.captain
                }
                view.modalPresentationStyle = .fullScreen
                self.present(view, animated: true, completion: nil)
            }
        }
    }

}
