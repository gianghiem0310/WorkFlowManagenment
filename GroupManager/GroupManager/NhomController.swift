//
//  GroupController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class NhomController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var mangNhom:[Nhom] = []
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
        database.child(Enum.NHOM_TABLE).child("0").observe(DataEventType.value){ (snapshot) in
            for child in snapshot.children{
                if let snap = child as? DataSnapshot{
                    if let snap2 = snap.value as? NSDictionary{
                        let id = snap2["id"] as? Int ?? -1
                        let title = snap2["title"] as? String ?? ""
                        let image = snap2["image"] as? String ?? ""
                        let quantity = snap2["quantity"] as? Int ?? -1
                        let captain = snap2["captain"] as? Int ?? -1
                        let status = snap2["status"] as? Bool ?? false
                        let us = Nhom(id: id, title: title, image: image, quantity: quantity, captain: captain, status: status)
                        self.mangNhom.append(us)
                        self.tableView.reloadData()
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
