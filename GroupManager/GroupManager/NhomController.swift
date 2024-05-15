//
//  GroupController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class NhomController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var mangNhom:[Group] = []
    var idUser = 15
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangNhom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "groupCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? NhomCell else{
            return UITableViewCell()
        }
        if mangNhom.count > 0{
            let data = mangNhom[indexPath.row]
            cell.tenNhom.text = data.title
            cell.soLuong.text = "\(data.quantity) Thành viên"
            cell.data = data
            let imageUrlString = data.image
            Enum.setImageFromURL(urlString: imageUrlString, imageView: cell.anhNhom)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){action,indexPath in
            let storyboard = Enum.STORYBOARD
            if let des = storyboard.instantiateViewController(identifier: "taoNhom") as? TaoNhomController{
                let navigation = UINavigationController(rootViewController: des)
                 navigation.modalPresentationStyle = .fullScreen
                des.manHinh = false
                des.nhomEdit = self.mangNhom[indexPath.row]
                 self.present(navigation, animated: true, completion: nil)
            }
        }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
            
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn muốn xoá nhóm này?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "Chắc chắn", style: .destructive){_ in
                let database = Enum.DB_REALTIME
                database.child(Enum.GROUP_TABLE).child("\(self.mangNhom[indexPath.row].id)").removeValue(){
                    (error,_)in
                    if let error = error{
                        self.thongBao(message: "Không thể xoá!")
                    }
                    else{
                        
                        database.child(Enum.GROUP_JOIN_TABLE).child("\(self.idUser)").child("\(self.mangNhom[indexPath.row].id)").removeValue()
                        self.mangNhom.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        tableView.reloadData()
                        self.thongBao(message: "Xoá nhóm thành công!")
                    }
                }
            }
            alert.addAction(cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
            
        }
        return [deleteAction,editAction]
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    // Override to support conditional editing of the table view.
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! NhomCell
        let storyboard = Enum.STORYBOARD
        if let des = storyboard.instantiateViewController(identifier: "duAnController") as? DuAnController{
            let navigation = UINavigationController(rootViewController: des)
             navigation.modalPresentationStyle = .fullScreen
            des.group = cell.data
             self.present(navigation, animated: true, completion: nil)
        }
    }
  
    
    

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      
        
        // Do any additional setup after loading the view.
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mangNhom.removeAll()
        tableView.reloadData()
        let database = Enum.DB_REALTIME
        database.child(Enum.GROUP_JOIN_TABLE).child("\(idUser)").observe(DataEventType.value){ (snapshot) in
            self.mangNhom.removeAll()
            if snapshot.childrenCount > 0{
                for child in snapshot.children{
                    if let snap = child as? DataSnapshot{
                        if let snap2 = snap.value as? NSDictionary{
                            let id = snap2["id"] as? Int ?? -1
                            database.child(Enum.GROUP_TABLE).child(String(id)).observe(DataEventType.value){ (snapshotIn) in
                                if let snapHe = snapshotIn as? DataSnapshot{
                                   print(snapHe)
                                    if let snap3 = snapHe.value as? NSDictionary{
                                    
                                        let idIn = snap3["id"] as? Int ?? -1
                                        let title = snap3["title"] as? String ?? ""
                                        let image = snap3["image"] as? String ?? ""
                                        let quantity = snap3["quantity"] as? Int ?? -1
                                        let captain = snap3["captain"] as? Int ?? -1
                                        let status = snap3["status"] as? Bool ?? false
                                        let join = snap3["join"] as? Int ?? -1
                                        let us = Group(id: idIn, title: title, image: image, quantity: quantity, captain: captain, status: status,join: join)
                                        
                                        
                                        
                                        self.mangNhom.append(us)
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
   

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        if segue.identifier == "segueGroup"{
//            if let viewConB = segue.destination as? DuAnController{
//                viewConB.group = data
//            }
//        }
//    }
    

}
