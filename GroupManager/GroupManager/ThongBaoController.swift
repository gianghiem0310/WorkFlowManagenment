//
//  NotificationController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase


class ThongBaoController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var idUser = 1
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mangThongBao.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = mangThongBao[indexPath.row]
        let type = data.type
        var iden = "xacNhanThamGia"
        
        switch type {
        case Enum.THAM_GIA_GROUP,
             Enum.THAM_GIA_DEADLINE,
             Enum.THAM_GIA_JOB,
             Enum.XAC_NHAN_COMPLETE:
            iden = "xacNhanThamGia"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: iden,for: indexPath) as? XacNhanThamGiaCell else{
                return UITableViewCell()
            }
            cell.data = data
            cell.view = self
            cell.content.text = data.content
            cell.date.text = data.date
            let database = Enum.DB_REALTIME
            database.child(Enum.GROUP_TABLE).child("\(data.idGroup)").observe(DataEventType.value){
                snapshot in
                if snapshot.childrenCount > 0{
                    if let object = snapshot.value as? NSDictionary{
                        let title = object["title"] as? String ?? ""
                        let image = object["image"] as? String ?? ""
                        cell.titleGroup.text = title
                        Enum.setImageFromURL(urlString: image, imageView: cell.imageNoti)
                    }
                }
            }
            return cell
           
        case Enum.NHAC_NHO,
             Enum.TEXT_BINH_THUONG,
             Enum.BI_XOA_KHOI_GROUP,
             Enum.BI_XOA_KHOI_DEADLINE,
             Enum.BI_XOA_KHOI_JOB:
            iden = "textBinhThuong"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: iden,for: indexPath) as?  TextBinhThuongCell else{
                return UITableViewCell()
            }
            cell.data = data
            cell.contentNoti.text = data.content
            cell.date.text = data.date
            let database = Enum.DB_REALTIME
            database.child(Enum.GROUP_TABLE).child("\(data.idGroup)").observe(DataEventType.value){
                snapshot in
                if snapshot.childrenCount > 0{
                    if let object = snapshot.value as? NSDictionary{
                        let title = object["title"] as? String ?? ""
                        
                        let image = object["image"] as? String ?? ""
                        cell.titleNoti.text = title
                        
                        Enum.setImageFromURL(urlString: image, imageView: cell.imageNoti)
                    }
                }
            }
            return cell
        default:
            iden = "xacNhanThamGia"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: iden,for: indexPath) as?  XacNhanThamGiaCell else{
                return UITableViewCell()
            }
            cell.data = data
            cell.view = self
            cell.content.text = data.content
            cell.date.text = data.date
            let database = Enum.DB_REALTIME
            database.child(Enum.GROUP_TABLE).child("\(data.idGroup)").observe(DataEventType.value){
                snapshot in
                if snapshot.childrenCount > 0{
                    if let object = snapshot.value as? NSDictionary{
                        let title = object["title"] as? String ?? ""
                        let image = object["image"] as? String ?? ""
                        cell.titleGroup.text = title
                        Enum.setImageFromURL(urlString: image, imageView: cell.imageNoti)
                    }
                }
            }
            return cell
            
        }
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let data = self.mangThongBao[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
            
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chắc chắn muốn xoá thông báo này ?", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "Chắc chắn", style: .destructive){_ in
                let database = Enum.DB_REALTIME
                database.child(Enum.NOTIFICATION_TABLE).child("\(self.idUser)").child("\(data.idSender)").child("\(data.id)").removeValue()
                
                self.mangThongBao.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()
                self.thongBao(message: "Đã xoá!")
                
            }
            alert.addAction(cancel)
            alert.addAction(confirm)
            self.present(alert, animated: true, completion: nil)
            
          
        }
        return [deleteAction]
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var mangThongBao = [Notification]()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDataForTableView()
    }
    func getDataForTableView() {
        let database = Enum.DB_REALTIME
        database.child(Enum.NOTIFICATION_TABLE).child("\(idUser)").observe(DataEventType.value){
            snapshot in
            self.mangThongBao.removeAll()
            self.tableView.reloadData()
            if snapshot.childrenCount > 0{
                for child in snapshot.children{
                    if let childV2 = child as? DataSnapshot {
                        if childV2.childrenCount > 0{
                            self.mangThongBao.removeAll()
                            self.tableView.reloadData()
                            for item in childV2.children {
                                if let value = item as? DataSnapshot {
                                    if let object = value.value as? NSDictionary{
                                        let id = object["id"] as? Int ?? -1
                                        let idSender = object["idSender"] as? Int ?? -1
                                        let idReceiver = object["idReceiver"] as? Int ?? -1
                                        let content = object["content"] as? String ?? ""
                                        let type = object["type"] as? Int ?? -1
                                        let idGroup = object["idGroup"] as? Int ?? -1
                                        let idDeadline = object["idDeadline"] as? Int ?? -1
                                        let idJob = object["idJob"] as? Int ?? -1
                                        let date = object["date"] as? String ?? ""
                                        
                                        let noti = Notification(id: id, idSender: idSender, idReceiver: idReceiver, content: content, type: type, idGroup: idGroup, idDeadline: idDeadline, idJob: idJob, date: date)
                                        self.mangThongBao.append(noti)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
