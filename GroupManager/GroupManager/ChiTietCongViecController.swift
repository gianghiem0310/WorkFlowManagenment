//
//  ChiTietCongViecController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit
import FirebaseDatabase
class ChiTietCongViecController: UIViewController {
    var receivedData:CongViec?
    
    var job:Job?
    var idUser = 1
    var nameUser = "Nghiêm"
    var idCaptain:Int?
    var idGroup:Int?
    var deadline:Deadline?
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBAction func menu(_ sender: UIBarButtonItem) {
        
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
       
        let database = Enum.DB_REALTIME
        if let deadline = self.deadline,let job = job,let idGroup = self.idGroup{
            database.child(Enum.JOB_MEMBER_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)")
                .child("\(job.id)").child("\(idUser)").observe(DataEventType.value){
                    snapshot in
                    if snapshot.childrenCount>0{
                        if let child = snapshot.value as? NSDictionary{
                            let status = child["status"] as? Bool ?? false
                            if !status{  actionSheet.addAction(UIAlertAction(title: "Hoàn thành", style: .default, handler:{
                                    action in
                                    var kiemTra = true
                                    if kiemTra,let idGroup = self.idGroup, let job = self.job, let idCaptain = self.idCaptain{
                                        Enum.yeuCauXacNhanHoanThanhCongViec(idCaptain: idCaptain, idSender: self.idUser, nameSender: self.nameUser, idGroup: idGroup, job: job, closure: self.thongBaoThamGia)
                                    }
                                }))
                            }
                        }
                        actionSheet.addAction(UIAlertAction(title: "Rời Công việc", style: .destructive, handler:{
                            action in
                            self.roiJob()
                        }))
                        
                    }else{
                        actionSheet.addAction(UIAlertAction(title: "Tham gia công việc", style: .default, handler:{
                            action in
                           
                            if let idCaptain = self.idCaptain,self.idUser == idCaptain{
                                Enum.thamGiaJobCuaNhomtruong(job: job, deadline: deadline, idCaptain: idCaptain,idGroup: idGroup, closureThatBai: self.thongBaoJobDuNguoi, closureThanhCong: self.thongBaoJobThanhCong)
                            }else{
                                var kiemTra = true
                                if kiemTra,let idGroup = self.idGroup, let job = self.job, let idCaptain = self.idCaptain{
                                    Enum.xinVaoJob(idCaptain: idCaptain, idSender: self.idUser, nameSender: self.nameUser, idGroup: idGroup, job: job, closure: self.thongBaoThamGia)
                                }
                            }
                            
                            
                           
                        }))
                    }
                }
        }

        var kiemTra = true
        //End
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
            //Kiểm tra đã tham gia deadline chưa
            if let deadline = self.deadline{
                database.child(Enum.DEADLINE_JOIN_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)").child("\(self.idUser)").observe(DataEventType.value){
                    snapshot in
                    if snapshot.childrenCount>0 && kiemTra{
                        
                             actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .destructive, handler:nil))
                             self.present(actionSheet, animated: true, completion: nil)
                            kiemTra = false
                    }else{
                        self.thongBao(message: "Hãy tham gia dự án này trước!")
                    }
                }
            }
      
        }
       
        
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
   
   
    func thongBaoJobThanhCong(){
 
            let alert = UIAlertController(title: "Thông báo", message: "Thêm thành viên vào công việc thành công!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        
    }
    func thongBaoJobDuNguoi(){
    
            let alert = UIAlertController(title: "Thông báo", message: "Công việc đã đủ người", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
           present(alert, animated: true, completion: nil)
     
    }
    func thongBaoThamGia(){
        let alert = UIAlertController(title: "Thông báo", message: "Đã gửi yêu cầu cho nhóm trưởng!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func thongBaoXoa(){
        let alert = UIAlertController(title: "Thông báo", message: "Xoá thành công!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func roiJob() {
        if let idCaptain = idCaptain,let idGroup = idGroup,let job = job{
            Enum.roiJob(idReceiver: idCaptain, idSender: idUser, content: "\(nameUser) rời công việc \(job.title)", idGroup: idGroup, idDeadline: job.idDeadline, idJob: job.id, closure: self.thongBaoRoiNhom)
        }
    }
    func thongBaoRoiNhom(){
        let alert = UIAlertController(title: "Thông báo", message: "Rời công việc thành công!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var containerView: UIView!
    @IBAction func changView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let viewCu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
            viewCu.willMove(toParent: nil)
            viewCu.view.removeFromSuperview()
            viewCu.removeFromParent()
            
            
            let viewMoi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController1")
            
            addChild(viewMoi)
            viewMoi.view.frame = containerView.bounds
            containerView.addSubview(viewMoi.view)
            viewMoi.didMove(toParent: self)
            if let viewMoi1 = viewMoi as? FragmentChiTietCongViecController,let job = job{
                viewMoi1.job = job
                viewMoi1.nameJob.text = job.title
                viewMoi1.quantityJob.text =  "\(job.join)/\(job.quantity)"
                viewMoi1.deadlineJob.text = job.deadline
                viewMoi1.fitJob.text = "Điểm tích luỹ: \(job.point) fit"
                viewMoi1.descriptionJob.text = job.description
                Enum.setImageFromURL(urlString: job.image, imageView: viewMoi1.imageJob)
            }
            
        case 1:
            let viewCu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController1")
            viewCu.willMove(toParent: nil)
            viewCu.view.removeFromSuperview()
            viewCu.removeFromParent()
            
            
            let viewMoi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
            addChild(viewMoi)
            viewMoi.view.frame = containerView.bounds
            containerView.addSubview(viewMoi.view)
            viewMoi.didMove(toParent: self)
            if let viewMoi1 = viewMoi as? FragmentThanhVienCongViecController,let job = job,let deadline = deadline,let idCaptain = idCaptain{
                viewMoi1.job = job
                viewMoi1.deadline = deadline
                viewMoi1.idCaptain = idCaptain
            }
        default:
            let viewCu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
            viewCu.willMove(toParent: nil)
            viewCu.view.removeFromSuperview()
            viewCu.removeFromParent()
            
            
            let viewMoi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController1")
            
            addChild(viewMoi)
            viewMoi.view.frame = containerView.bounds
            containerView.addSubview(viewMoi.view)
            viewMoi.didMove(toParent: self)
            if let viewMoi1 = viewMoi as? FragmentChiTietCongViecController,let job = job{
                
                
                    viewMoi1.job = job
              
                viewMoi1.nameJob.text = job.title
                viewMoi1.quantityJob.text = "\(job.join)/\(job.quantity)"
                viewMoi1.deadlineJob.text = job.deadline
                viewMoi1.fitJob.text = "Điểm tích luỹ: \(job.point) fit"
                viewMoi1.descriptionJob.text = job.description
                Enum.setImageFromURL(urlString: job.image, imageView: viewMoi1.imageJob)
                    
                
                
            
            }
        }
    }
    
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
   
    func getDataUser(){
        idUser = UserDefaults.standard.integer(forKey: Enum.ID_USER)
        nameUser = UserDefaults.standard.string(forKey: Enum.NAME_USER) ?? ""
    }
   override func viewDidLoad() {
        super.viewDidLoad()
    getDataUser()
    if let job = job{
        navigation.title = job.title
    }
    let viewCu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
    viewCu.willMove(toParent: nil)
    viewCu.view.removeFromSuperview()
    viewCu.removeFromParent()
    
    
    let viewMoi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController1")
    
    addChild(viewMoi)
    viewMoi.view.frame = containerView.bounds
    containerView.addSubview(viewMoi.view)
    viewMoi.didMove(toParent: self)
    if let viewMoi1 = viewMoi as? FragmentChiTietCongViecController, let job = job{
        
        
            viewMoi1.job = job
      
        viewMoi1.nameJob.text = job.title
        viewMoi1.quantityJob.text = "\(job.join)/\(job.quantity)"
        viewMoi1.deadlineJob.text = job.deadline
        viewMoi1.fitJob.text = "Điểm tích luỹ: \(job.point) fit"
        viewMoi1.descriptionJob.text = job.description
        Enum.setImageFromURL(urlString: job.image, imageView: viewMoi1.imageJob)
            
        
        
    
    }
        // Do any additional setup after loading the view.
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
