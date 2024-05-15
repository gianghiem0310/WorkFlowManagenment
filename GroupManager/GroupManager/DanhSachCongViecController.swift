//
//  JobInProjectController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit
import FirebaseDatabase
import Firebase
class DanhSachCongViecController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //Start Nghiem
    var idUser = 1
    var nameUser = "Thành viên"
    var deadline:Deadline?
    var idCaptain:Int?
    
    @IBAction func menu(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        if let idCaptain = idCaptain{
            if idUser == idCaptain{
                actionSheet.addAction(UIAlertAction(title: "Tạo công việc", style: .default, handler:{
                    action in
                    self.thongBao(message: "Tạo công việc!")
                }))
            }
        }
        actionSheet.addAction(UIAlertAction(title: "Rời Project", style: .destructive, handler:{
            action in
            if let idCaptain = self.idCaptain,let deadline = self.deadline{
                Enum.roiDeadline(idReceiver: idCaptain, idSender: self.idUser, content: "\(self.nameUser) rời deadline \(deadline.deadline)", idGroup: deadline.idGroup, idDeadline: deadline.id)
                self.thongBao(message: "Đã rời khỏi Project này!")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .destructive, handler:nil))
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBOutlet weak var navigation: UINavigationItem!
    //End Nghiem
    var idView = 15
    var ar = [Job]()
    var ar2 = [1,2,3,4]
    var ar3 = [1,2]
    

    //Start Nghiem 2
    let database = Enum.DB_REALTIME
    func getDataForTableView() {
        if let deadline = deadline{
            database.child(Enum.JOB_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)").observe(DataEventType.value){
                snapshot in
                if snapshot.childrenCount>0{
                    self.ar.removeAll()
                    for child in snapshot.children{
                        if let childSnap = child as? DataSnapshot{
                            if let object = childSnap.value as? NSDictionary{
                                let id = object["id"] as? Int ?? -1
                                let idDeadline = object["idDeadline"] as? Int ?? -1
                                let title = object["title"] as? String ?? ""
                                let image = object["image"] as? String ?? ""
                                let quantity = object["quantity"] as? Int ?? -1
                                let description = object["description"] as? String ?? ""
                                let deadline = object["deadline"] as? String ?? ""
                                let point = object["point"] as? Int ?? -1
                                let titleDeadline = object["titleDeadline"] as? String ?? ""
                                let titleGroup = object["titleGroup"] as? String ?? ""
                                let status = object["status"] as? Bool ?? true
                                let join = object["join"] as? Int ?? -1
                                let job = Job(id: id, idDeadline: idDeadline, title: title, image: image, quantity: quantity, description: description, deadline: deadline, point: point, titleDeadline: title, titleGroup: titleGroup, status: status, join: join)
                                self.ar.append(job)
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
       
       
    }
    //End Nghiem 2
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            idView = 0
            tableView.reloadData()
        case 1:
            idView = 1
            tableView.reloadData()
        case 2:
            idView = 2
            tableView.reloadData()
        default:
            break
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if idView == 0 {
            return ar.count
        }
        if idView == 1 {
            return ar2.count
        }
        
        return ar3.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if idView == 0 {
            let identifier = "dangCanCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? DangCanCell else{
                return UITableViewCell()
            }
            return cell
        }
        if idView == 1 {
            let identifier = "chotCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? ChotCell else{
                return UITableViewCell()
            }
            return cell
        }
  
            let identifier = "thanhVienCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? ThanhVienCell else{
                return UITableViewCell()
            }
            return cell
    }
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setDataFirst()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getDataForTableView()
    }
    func setDataFirst(){
        if let deadline = deadline{
            navigation.title = deadline.deadline
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch idView {
        case 0:
            let storyboard = Enum.STORYBOARD
            if let view = storyboard.instantiateViewController(identifier: "chiTietCongViec") as? ChiTietCongViecController{
                if let idCaptain = idCaptain{
                    view.idCaptain = idCaptain
                    view.job = ar[indexPath.row]
                    view.modalPresentationStyle = .fullScreen
                    present(view, animated: true, completion: nil)
                }
            }
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
    }
    

}
