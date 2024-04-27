//
//  ProjectController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class DuAnController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
   
    @IBAction func tool(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Tạo dự án", style: .default, handler:{
            action in
            
            let storyboard = Enum.STORYBOARD
            if let des = storyboard.instantiateViewController(identifier: "taoDuAn") as? TaoDuAnController{
                let navigation = UINavigationController(rootViewController: des)
                 navigation.modalPresentationStyle = .fullScreen
                 self.present(navigation, animated: true, completion: nil)
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Thêm thành viên", style: .default, handler:{
            action in
            self.formAdd()
        }))
        actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .destructive, handler:nil))
        present(actionSheet, animated: true, completion: nil)
    }
    func formAdd() {
        let alert = UIAlertController(title: "Thêm thành viên", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Nhập email"
            textField.borderStyle = .line
        })
        let cancel = UIAlertAction(title: "Huỷ", style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "Đồng ý", style: .default, handler: {
            action in
            
        })
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            choose = true
            tableView.reloadData()
        case 1:
            choose = false
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
            let identifier = "memberProjectCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? ThanhVienCell else{
                return UITableViewCell()
            }
            return cell
        }
       
       
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
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
    }
    

    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    var choose = true
    var mangProject:[Deadline] = []
    var mangMember = [1,2,3,4,5,6]
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
                                let value = Deadline(id: id, idGroup: idGroup, deadline: deadline, quantity: quantity, status: status)
                                self.mangProject.append(value)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        } else {
            
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
