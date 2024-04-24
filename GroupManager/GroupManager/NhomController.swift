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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangNhom.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "groupCell"
        let data = mangNhom[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? NhomCell else{
            return UITableViewCell()
        }
        
            cell.tenNhom.text = data.title
        cell.soLuong.text = "\(data.quantity) Thành viên"
        
        let imageUrlString = data.image
        if let imageUrl = URL(string: imageUrlString){
            let task = URLSession.shared.dataTask(with: imageUrl){(data,response,error)in
                if let dataa = data{
                    if let image = UIImage(data: dataa){
                        DispatchQueue.main.async {
                            cell.anhNhom.image = image
                        }
                    }
                }
            }
            task.resume()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){action,indexPath in
            let storyboard = Enum.STORYBOARD
            if let des = storyboard.instantiateViewController(identifier: "taoNhom") as? TaoNhomController{
                des.title = "Sửa dự án"
                let navigation = UINavigationController(rootViewController: des)
                 navigation.modalPresentationStyle = .fullScreen
                 self.present(navigation, animated: true, completion: nil)
            }
        }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
            self.mangNhom.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [editAction,deleteAction]
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    // Override to support conditional editing of the table view.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  
    
    

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
        
        let database = Enum.DB_REALTIME
        database.child(Enum.GROUP_JOIN_TABLE).child("15").observe(DataEventType.value){ (snapshot) in
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    if let snap2 = snap.value as? NSDictionary{
                        
                        let id = snap2["id"] as? Int ?? -1
                        
                        database.child(Enum.GROUP_TABLE).child(String(id)).observe(DataEventType.value){ (snapshotIn) in
                            if let snapHe = snapshotIn as? DataSnapshot{
                                if let snap3 = snapHe.value as? NSDictionary{
                                
                                    let idIn = snap3["id"] as? Int ?? -1
                                    let title = snap3["title"] as? String ?? ""
                                    let image = snap3["image"] as? String ?? ""
                                    let quantity = snap3["quantity"] as? Int ?? -1
                                    let captain = snap3["captain"] as? Int ?? -1
                                    let status = snap3["status"] as? Bool ?? false
                                    let us = Group(id: idIn, title: title, image: image, quantity: quantity, captain: captain, status: status)
                                    
                                    
                                    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
