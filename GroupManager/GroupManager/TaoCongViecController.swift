//
//  TaoCongViecController.swift
//  GroupManager
//
//  Created by Nguyen Hong Phuc on 4/26/24.
//

import UIKit
import FirebaseDatabase

class TaoCongViecController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var state = true
    
    var job:Job?
    var idGroup:Int?
    var idDeadline:Int?
    var titleDeadline:String?
    var titleGroup:String?
    
    var tieuDe = ""
    var ngayHetHan = ""
    var soLuongCan = ""
    var moTa = ""
    var fit = ""
    var image = "NULL"
    var imageLayRa:UIImage?
    var activityIndicator: UIActivityIndicatorView!
    
    let storage = Enum.DB_STORAGE
    @IBOutlet weak var txtTieuDe: UITextField!
    
    @IBOutlet weak var txtSoLuongCan: UITextField!
    
    @IBOutlet weak var txtMoTa: UITextField!
    
    @IBOutlet weak var txtDiemFit: UITextField!
    
    @IBOutlet weak var dateHanCongViec: UIDatePicker!
    
    
    @IBOutlet weak var imageJob: UIImageView!
    
    
    @IBOutlet weak var nameGroup: UILabel!
    
    @IBOutlet weak var nameDeadline: UILabel!
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        txtMoTa.delegate = self
        txtDiemFit.delegate = self
        txtTieuDe.delegate = self
        txtSoLuongCan.delegate = self
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGes)
        
        
        customGiaoDien()
        getIdLienTuc()
        
        if let tenNhom = titleGroup, let tenDeadline = titleDeadline{
            nameGroup.text = tenNhom
            nameDeadline.text = tenDeadline
            
        }
        
        checkCongJob()
        
        // Khởi tạo UIActivityIndicatorView
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    let database = Enum.DB_REALTIME
    var idNew = 0
    func getIdLienTuc(){
        if let idGroup = idGroup, let idDeadline = idDeadline{
            let groupRef = database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)")
            let lastElement = groupRef.queryOrderedByKey().queryLimited(toLast: 1)
            lastElement.observeSingleEvent(of: .value){
                (snapshot) in
                guard snapshot.exists() else{
                    self.idNew = 0
                    return
                }
                if let lastE = snapshot.children.allObjects.first as? DataSnapshot{
                    if let child = lastE.value as? NSDictionary{
                        self.idNew = child["id"] as? Int ?? -1
                        self.idNew += 1
                    }
                }
            }
        }
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getIdLienTuc()
    }
    
    func toggleActivityIndicator(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func checkCongJob() {
        if state{
            navItem.title = "Tạo công việc"
        }else{
            navItem.title = "Sửa công việc"
            setDataEditJob()
            
        }
        
    }
    
    
    
    
    func setDataEditJob() {
        if let job = job{
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            if let date = dateFormat.date(from:  job.deadline){
                txtMoTa.text = job.description
                txtTieuDe.text = job.title
                txtSoLuongCan.text = String(job.quantity)
                txtDiemFit.text = String(job.point)
                dateHanCongViec.date = date
                let imageUrlString = job.image
                Enum.setImageFromURL(urlString: imageUrlString, imageView: self.imageJob)
            }else{
                self.thongBao(message: "Không chuyển đổi ngày được")
            }
        }
    }
    func taoThanhCong()  {
        self.thongBao(message: "Tạo công việc thành công")
        self.txtMoTa.text = ""
        self.txtTieuDe.text = ""
        self.txtDiemFit.text = ""
        self.txtSoLuongCan.text = ""
        self.toggleActivityIndicator(false)
    }
    
    
    func addJob() {
        let currentDate = Date()
        let datePicker = self.dateHanCongViec.date
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let ngayHetHanDeadline = dateFormat.string(from: datePicker)
        
        
        if let tieuDe = self.txtTieuDe, let soLuongCan = self.txtSoLuongCan, let moTa = self.txtMoTa, let fit = self.txtDiemFit, let idDeadline = self.idDeadline, let idGroup = self.idGroup, let titleDeadline = self.titleDeadline, let titleGroup = self.titleGroup{
            if let tieuDe = tieuDe.text,let soLuongCan = soLuongCan.text, let moTa = moTa.text, let fit = fit.text{
                
                let comparisonResult = Calendar.current.compare(currentDate, to: datePicker, toGranularity: .day)
                if comparisonResult == .orderedAscending {
                    if let image = self.imageLayRa {
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                            return
                        }
                        let imageName = "job\(self.idNew).jpeg"
                        let imageRef = self.storage.child("images/\(imageName)")
                        let uploadTask = imageRef.putData(imageData,metadata: nil){
                            (metadata, error) in imageRef.downloadURL{
                                (url, error) in
                                if let dowloadURL = url{
                                    let job = Job(id: self.idNew, idDeadline: idDeadline, title: tieuDe, image: dowloadURL.absoluteString, quantity: Int(soLuongCan) ?? -1, description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1, titleDeadline: titleDeadline, titleGroup: titleGroup, status: true, join: 0)
                                    self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(self.idNew)").setValue(job.toDictionary())
                                    self.taoThanhCong()
                                    
                                }
                                else{
                                    return
                                }
                            }
                        }
                        uploadTask.observe(.success){
                            snap in
                        }
                        
                    }else{
                        let job = Job(id: self.idNew, idDeadline: idDeadline, title: tieuDe, image: "NULL", quantity: Int(soLuongCan) ?? -1, description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1, titleDeadline: titleDeadline, titleGroup: titleGroup, status: true, join: 0)
                        self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(self.idNew)").setValue(job.toDictionary())
                        
                        taoThanhCong()
                    }
                    
                } else if comparisonResult == .orderedDescending {
                    self.thongBao(message: "Ngày hết hạn Deadline không hợp lệ!")
                    self.toggleActivityIndicator(false)
                } else {
                    if let image = self.imageLayRa {
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                            return
                        }
                        let imageName = "job\(self.idNew).jpeg"
                        let imageRef = self.storage.child("images/\(imageName)")
                        let uploadTask = imageRef.putData(imageData,metadata: nil){
                            (metadata, error) in imageRef.downloadURL{
                                (url, error) in
                                if let dowloadURL = url{
                                    let job = Job(id: self.idNew, idDeadline: idDeadline, title: tieuDe, image: dowloadURL.absoluteString, quantity: Int(soLuongCan) ?? -1, description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1, titleDeadline: titleDeadline, titleGroup: titleGroup, status: true, join: 0)
                                    self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(self.idNew)").setValue(job.toDictionary())
                                    
                                    self.taoThanhCong()
                                }
                                else{
                                    return
                                }
                            }
                        }
                        uploadTask.observe(.success){
                            snap in
                        }
                        
                    }else{
                        let job = Job(id: self.idNew, idDeadline: idDeadline, title: tieuDe, image: "NULL", quantity: Int(soLuongCan) ?? -1, description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1, titleDeadline: titleDeadline, titleGroup: titleGroup, status: true, join: 0)
                        self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(self.idNew)").setValue(job.toDictionary())
                        
                        taoThanhCong()
                    }
                }
            }
        }
        
    }
    
    
    func editJob()  {
        let currentDate = Date()
        let datePicker = self.dateHanCongViec.date
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let ngayHetHanDeadline = dateFormat.string(from: datePicker)
        
        let comparisonResult = Calendar.current.compare(currentDate, to: datePicker, toGranularity: .day)
        
        if let tieuDe = self.txtTieuDe, let soLuongCan = self.txtSoLuongCan, let moTa = self.txtMoTa, let fit = self.txtDiemFit, let idDeadline = self.idDeadline, let idGroup = self.idGroup, let titleDeadline = self.titleDeadline, let titleGroup = self.titleGroup{
            if let tieuDe = tieuDe.text,let soLuongCan = soLuongCan.text, let moTa = moTa.text, let fit = fit.text{
                if comparisonResult == .orderedAscending {
                    if let image = self.imageLayRa{
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                            return
                        }
                        let imageName = "job\(self.idNew).jpeg"
                        let imageRef = self.storage.child("images/\(imageName)")
                        let uploadTask = imageRef.putData(imageData,metadata: nil){
                            (metadata,error) in
                            imageRef.downloadURL{(url,eror)in
                                guard let downloadURL = url else{
                                    return
                                }
                                
                                if let job = self.job{
                                    self.image = downloadURL.absoluteString
                                    
                                    let job = Job(id: job.id, idDeadline: idDeadline, title: tieuDe, image: self.image, quantity: Int(soLuongCan) ?? -1, description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1, titleDeadline: titleDeadline, titleGroup: titleGroup, status: job.status, join: job.join)
                                    
                                    self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(job.id)").setValue(job.toDictionary()){
                                        (result,error) in
                                        guard error != nil else{
                                            self.thongBao(message: "Chỉnh sửa thất bại!")
                                            return
                                        }
                                        
                                        self.thongBao(message: "Chỉnh sửa thành công!")
                                        self.toggleActivityIndicator(false)
                                    }
                                }
                                
                            }
                        }
                        
                        uploadTask.observe(.success){
                            snap in
                            
                        }
                    }
                    else{
                        if let job = self.job{
                            let job = Job(id: job.id, idDeadline: idDeadline, title: tieuDe, image: job.image, quantity: Int(soLuongCan) ?? -1 , description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1, titleDeadline: titleDeadline, titleGroup: titleGroup, status: job.status, join: job.join)
                            
                            self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(job.id)").setValue(job.toDictionary()){
                                (result,error) in
                                guard error != nil else{
                                    self.thongBao(message: "Chỉnh sửa thất bại!")
                                    return
                                }
                                
                                self.thongBao(message: "Chỉnh sửa thành công!")
                                self.toggleActivityIndicator(false)
                            }
                        }
                        
                    }
                    
                }
                else if comparisonResult == .orderedDescending {
                    self.thongBao(message: "Ngày hết hạn Deadline không hợp lệ!")
                    self.toggleActivityIndicator(false)
                }else{
                    
                    
                    if let image = self.imageLayRa{
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                            return
                        }
                        let imageName = "job\(self.idNew).jpeg"
                        let imageRef = self.storage.child("images/\(imageName)")
                        let uploadTask = imageRef.putData(imageData,metadata: nil){
                            (metadata,error) in
                            imageRef.downloadURL{(url,eror)in
                                guard let downloadURL = url else{
                                    return
                                }
                                
                                if let job = self.job{
                                    self.image = downloadURL.absoluteString
                                    
                                    let job = Job(id: job.id, idDeadline: idDeadline, title: tieuDe, image: self.image, quantity: Int(soLuongCan) ?? -1, description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1, titleDeadline: titleDeadline, titleGroup: titleGroup, status: job.status, join: job.join)
                                    
                                    self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(job.id)").setValue(job.toDictionary()){
                                        (result,error) in
                                        guard error != nil else{
                                            self.thongBao(message: "Chỉnh sửa thất bại!")
                                            return
                                        }
                                        
                                        self.thongBao(message: "Chỉnh sửa thành công!")
                                        self.toggleActivityIndicator(false)
                                    }
                                }
                                
                            }
                        }
                        
                        uploadTask.observe(.success){
                            snap in
                            
                        }
                        
                        
                    }
                    else{
                        if let job = self.job{
                            let job = Job(id: job.id, idDeadline: idDeadline, title: tieuDe, image: job.image, quantity: Int(soLuongCan) ?? -1, description: moTa, deadline: ngayHetHanDeadline, point:Int (fit) ?? -1 , titleDeadline: titleDeadline, titleGroup: titleGroup, status: job.status, join: job.join)
                            
                            self.database.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(job.id)").setValue(job.toDictionary()){
                                (result,error) in
                                guard error != nil else{
                                    self.thongBao(message: "Chỉnh sửa thất bại!")
                                    return
                                }
                                
                                self.thongBao(message: "Chỉnh sửa thành công!")
                                self.toggleActivityIndicator(false)
                            }
                        }
                        
                    }
                    
                }
                
                
            }
        }
    }
    
    
    @IBAction func btnXong(_ sender: UIBarButtonItem) {
        toggleActivityIndicator(true)
        if state {
            getIdLienTuc()
            
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                
                if let tieuDe = self.txtTieuDe, let soLuongCan = self.txtSoLuongCan, let moTa = self.txtMoTa, let fit = self.txtDiemFit{
                    if let tieuDe = tieuDe.text,let soLuongCan = soLuongCan.text, let moTa = moTa.text, let fit = fit.text{
                        if !tieuDe.isEmpty && !soLuongCan.isEmpty
                            && !moTa.isEmpty && !fit.isEmpty{
                            if let _ = Int(soLuongCan){
                                if let _ = Int(fit){
                                    self.addJob()
                                }else{
                                    self.thongBao(message: "Điểm fit phải là ký tự số!")
                                    self.toggleActivityIndicator(false)
                                }
                            }else{
                                self.thongBao(message: "Số lượng phải là ký tự số!")
                                self.toggleActivityIndicator(false)
                            }
                        }else{
                            self.thongBao(message: "Hãy nhập đủ các trường")
                            self.toggleActivityIndicator(false)
                        }
                    }
                }
            }
        }else{
            print("chinh sua")
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                
                if let tieuDe = self.txtTieuDe, let soLuongCan = self.txtSoLuongCan, let moTa = self.txtMoTa, let fit = self.txtDiemFit{
                    if let tieuDe = tieuDe.text,let soLuongCan = soLuongCan.text, let moTa = moTa.text, let fit = fit.text{
                        
                        if !tieuDe.isEmpty && !soLuongCan.isEmpty
                            && !moTa.isEmpty && !fit.isEmpty{
                            print("ok")
                            if let _ = Int(soLuongCan){
                                if let _ = Int(fit){
                                    
                                    self.editJob()
                                    
                                }else{
                                    self.thongBao(message: "Điểm fit phải là ký tự số!")
                                    self.toggleActivityIndicator(false)
                                }
                            }else{
                                self.thongBao(message: "Số lượng phải là ký tự số!")
                                self.toggleActivityIndicator(false)
                            }
                            
                        }else{
                            self.thongBao(message: "Chưa điền đủ thông tin!")
                            self.toggleActivityIndicator(false)
                        }
                    }
                    
                }
            }
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        txtTieuDe.resignFirstResponder()
        txtMoTa.resignFirstResponder()
        txtDiemFit.resignFirstResponder()
        txtSoLuongCan.resignFirstResponder()
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage]{
            imageJob.image = image as? UIImage
            imageLayRa = image as? UIImage
        }
        dismiss(animated: true)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtTieuDe.resignFirstResponder()
        txtSoLuongCan.resignFirstResponder()
        txtMoTa.resignFirstResponder()
        txtDiemFit.resignFirstResponder()
        return true
    }
    
    func customGiaoDien()  {
        txtTieuDe.layer.borderColor = UIColor.gray.cgColor
        txtTieuDe.layer.borderWidth = 2
        txtTieuDe.layer.cornerRadius = 10
        txtSoLuongCan.layer.borderColor = UIColor.gray.cgColor
        txtSoLuongCan.layer.borderWidth = 2
        txtSoLuongCan.layer.cornerRadius = 10
        txtMoTa.layer.borderColor = UIColor.gray.cgColor
        txtMoTa.layer.borderWidth = 2
        txtMoTa.layer.cornerRadius = 10
        txtDiemFit.layer.borderColor = UIColor.gray.cgColor
        txtDiemFit.layer.borderWidth = 2
        txtDiemFit.layer.cornerRadius = 10
        
        dateHanCongViec.layer.borderColor = UIColor.gray.cgColor
        dateHanCongViec.layer.borderWidth = 2
        dateHanCongViec.layer.cornerRadius = 10
        
    }
    
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
