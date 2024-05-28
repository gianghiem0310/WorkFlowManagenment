//
//  ThanhVienCongViecController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit
import FirebaseDatabase

class FragmentThanhVienCongViecController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var job:Job?
    var deadline:Deadline?
    var idUser = 0
    var idCaptain = -1
    var array = [Profile]()
    let database = Enum.DB_REALTIME
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Sai
//        let cell = tableView.dequeueReusableCell(withIdentifier: "thanhVienCongViecCell") as! ThanhVienCongViecCell
//
//        let item = array[indexPath.item]
//
//        cell.imageAvatar = UIImageView(image: UIImage(named: item.avatar))
//        cell.name.text = item.name
//        cell.trangThai.text = item.trangThai
        //Sai
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "thanhVienCongViecCell",for: indexPath) as? ThanhVienCongViecCell else{
            return UITableViewCell()
        }
        let child = array[indexPath.row]
        Enum.setImageFromURL(urlString: child.avatar, imageView: cell.imageAvatar)
        cell.name.text = child.name
        
        if let deadline = deadline,let job = job{
            database.child(Enum.JOB_MEMBER_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)").child("\(job.id)").child("\(child.idAccount)").observe(DataEventType.value){
                snapshot in
                if snapshot.childrenCount>0{
                    if let object = snapshot.value as? NSDictionary{
                        let status = object["status"] as? Bool ?? false
                        cell.trangThai.text = "\(status ? "  Hoàn thành  " : "  Chưa hoàn thành  " )"
                        cell.trangThai.backgroundColor = status ? .systemBlue : .systemOrange
                    }
                }
            }
            cell.idCaptain = self.idCaptain
            cell.titleJob = job.title
            cell.profile = child
            cell.view = self
        }
       
     
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getDataUser()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDataFromTableView()
    }
    //Nghiem set Du Lieu G
    func getDataUser(){
        idUser = UserDefaults.standard.integer(forKey: Enum.ID_USER)
    }
    func getDataFromTableView(){
        if let job = job,let deadline = deadline{
            database.child(Enum.JOB_MEMBER_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)").child("\(job.id)").observe(DataEventType.value){
                snapshot in
                self.array.removeAll()
                if snapshot.childrenCount > 0{
                    for child in snapshot.children{
                        if let childDataSnap = child as? DataSnapshot{
                            if let childValue = childDataSnap.value as? NSDictionary{
                                let id = childValue["id"] as? Int ?? -1
                                self.database.child(Enum.PROFILE_TABLE).child("\(id)").observe(DataEventType.value){
                                    snapshot in
                                    if snapshot.childrenCount>0{
                                        if let object = snapshot.value as? NSDictionary{
                                            let idAccount = object["idAccount"] as? Int ?? -1
                                            let avatar = object["avatar"] as? String ?? ""
                                            let name = object["name"] as? String ?? ""
                                            let phone = object["phone"] as? String ?? ""
                                            let email = object["email"] as? String ?? ""
                                            let fit = object["fit"] as? Int ?? -1
                                            let profile = Profile(idAccount: idAccount, avatar: avatar, name: name, phone: phone, email: email, fit: fit)
                                            self.array.append(profile)
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
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
            self.thongBao(message: "Chức năng dành cho nhóm trưởng!")
        }
        if idUser == idCaptain,let deadline = deadline,let job = job{
            let data = array[indexPath.row]
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn muốn xoá thành viên \(data.name)?", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
                let confirm = UIAlertAction(title: "Chắc chắn", style: .destructive){_ in
                    
                    Enum.xoaThanhVienJob(profileMember: data, idGroup: deadline.idGroup, job: job, idCaptain: self.idCaptain, closure: self.thongBao)
                    self.array.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                
                    
                }
                alert.addAction(cancel)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
            }
            return [deleteAction]
           
        }
        return [deleteAction]
    }
    func thongBao(){
        let alert = UIAlertController(title: "Thông báo", message: "Xoá thành viên thành công!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
   
    //End

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
