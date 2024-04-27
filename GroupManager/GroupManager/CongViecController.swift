//
//  JobController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class CongViecController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var mang:[Job] = []
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "congViecCaNhanCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? CongViecCaNhanCell else{
            return UITableViewCell()
        }
        let data = mang[indexPath.row]
        cell.tenCongViec.text = data.title
        cell.deadline.text = data.deadline
        cell.nhomCongViec.text = data.titleGroup
        let imageUrlString = data.image
        Enum.setImageFromURL(urlString: imageUrlString, imageView: cell.anhCongViec)
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){action,indexPath in

        }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
            self.mang.remove(at: indexPath.row)
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
    var idUser = 15

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataForTableView()
    }
    func getDataForTableView(){
        let database = Enum.DB_REALTIME
        database.child(Enum.JOB_NOT_COMPLETE).child("\(idUser)").observe(DataEventType.value){
            (snapAccount) in
            self.mang.removeAll()
            if snapAccount.childrenCount>0{
                for childAccount in snapAccount.children{
                    if let snapGroup = childAccount as? DataSnapshot{
                        if snapGroup.childrenCount>0{
                            for childGroup in snapGroup.children{
                                if let snapDeadline = childGroup as? DataSnapshot{
                                    if snapDeadline.childrenCount>0{
                                        for chilDeadline in snapDeadline.children{
                                            if let snapJob = chilDeadline as? DataSnapshot{
                                                if let childJob = snapJob.value as? NSDictionary{
                                                    let id = childJob["id"] as? Int ?? -1
                                                    let idDeadline = childJob["idDeadline"] as? Int ?? -1
                                                    let title = childJob["title"] as? String ?? ""
                                                    let image = childJob["image"] as? String ?? ""
                                                    let quantity = childJob["quantity"] as? Int ?? -1
                                                    let description = childJob["description"] as? String ?? ""
                                                    let deadline = childJob["deadline"] as? String ?? ""
                                                    let point = childJob["point"] as? Int ?? -1
                                                    let status = childJob["status"] as? Bool ?? true
                                                    let titleGroup = childJob["titleGroup"] as? String ?? ""
                                                    let titleDeadline = childJob["titleDeadline"] as? String ?? ""
                                                    let congViec = Job(id: id, idDeadline: idDeadline, title: title, image: image, quantity: quantity, description: description, deadline: deadline, point: point, titleDeadline: titleDeadline, titleGroup: titleGroup, status: status)
                                                    self.mang.append(congViec)
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
            else{
                self.thongBao(message: "Không có dữ liệu!")
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
