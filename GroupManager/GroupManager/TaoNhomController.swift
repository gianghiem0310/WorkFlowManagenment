//
//  CreateGroupController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class TaoNhomController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        if manHinh {
            if let quantity = Int(soLuong){
                if !tenNhom.isEmpty && !soLuong.isEmpty
                    {
                          
                    let storage = Enum.DB_STORAGE
                    if let image = imageLayRa{
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                            return
                        }
                        
                        let imageName = "Nhom\(idNhom).jpeg"
                        let imageRef = storage.child("images/\(imageName)")
                        let uploadTask = imageRef.putData(imageData,metadata: nil){
                            (metadata,error) in
                            imageRef.downloadURL{(url,eror)in
                                guard let downloadURL = url else{
                                    return
                                }
                                
                                self.anh = downloadURL.absoluteString
                                let nhom = Group(id: self.idNhom, title: self.tenNhom, image: self.anh, quantity: quantity, captain: self.idUser, status: self.status)
                                let database = Enum.DB_REALTIME
                                database.child(Enum.GROUP_TABLE).child("\(self.idNhom)").setValue(nhom.toDictionary()){
                                (result,error) in
                                guard error != nil else{
                                    self.thongBao(message: "Tạo nhóm thất bại!")
                                    return
                                }
                                    database.child(Enum.GROUP_JOIN_TABLE).child("\(self.idUser)").child("\(nhom.id)").child("id").setValue(nhom.id)
                                self.thongBao(message: "Tạo nhóm thành công!")
                                self.inputTen.text = ""
                                self.inputSoLuong.text = ""
                                self.anh = "NULL"
                                self.imageLayRa = nil
                                    self.imageNhom.image = UIImage(named: "default")
                                }
                            }
                        }
                        
                        uploadTask.observe(.success){
                            snap in
                            
                        }
                        
                        
                    }
                    else{
                        
                        let nhom = Group(id: idNhom, title: tenNhom, image: anh, quantity: quantity, captain: idUser, status: status)
                        let database = Enum.DB_REALTIME
                        database.child(Enum.GROUP_TABLE).child("\(idNhom)").setValue(nhom.toDictionary()){
                        (result,error) in
                        guard error != nil else{
                            self.thongBao(message: "Tạo nhóm thất bại!")
                            return
                        }
                            database.child(Enum.GROUP_JOIN_TABLE).child("\(self.idUser)").child("\(nhom.id)").child("id").setValue(nhom.id)
                        self.thongBao(message: "Tạo nhóm thành công!")
                        self.inputTen.text = ""
                        self.inputSoLuong.text = ""
                        }
                        
                    }
                    }else{
                        self.thongBao(message: "Thông tin còn thiếu!")
                    }
            }
            else{
                self.thongBao(message: "Số lượng phải là kí tự số!")
            }
        }else{
            if let quantity = Int(soLuong){
                if !tenNhom.isEmpty && !soLuong.isEmpty
                    {
                    let storage = Enum.DB_STORAGE
                    if let image = imageLayRa{
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                            return
                        }
                        let imageName = "Nhom\(self.nhomEdit?.id).jpeg"
                        let imageRef = storage.child("images/\(imageName)")
                        let uploadTask = imageRef.putData(imageData,metadata: nil){
                            (metadata,error) in
                            imageRef.downloadURL{(url,eror)in
                                guard let downloadURL = url else{
                                    return
                                }
                                
                                if let nhomEdit = self.nhomEdit{
                                    self.anh = downloadURL.absoluteString
                                    let nhom = Group(id: nhomEdit.id, title: self.tenNhom, image: self.anh, quantity: quantity, captain: nhomEdit.captain, status: nhomEdit.status)
                                    let database = Enum.DB_REALTIME
                                    database.child(Enum.GROUP_TABLE).child("\(nhomEdit.id)").setValue(nhom.toDictionary()){
                                    (result,error) in
                                    guard error != nil else{
                                        self.thongBao(message: "Chỉnh sửa thất bại!")
                                        return
                                    }
                                        
                                    self.thongBao(message: "Chỉnh sửa thành công!")
                                    }
                                }
                               
                            }
                        }
                        
                        uploadTask.observe(.success){
                            snap in
                            
                        }
                        
                        
                    }
                    else{
                        
                        if let nhomEdit = nhomEdit{
                            let nhom = Group(id: nhomEdit.id, title: tenNhom, image: nhomEdit.image, quantity: quantity, captain: nhomEdit.captain, status: nhomEdit.status)
                            let database = Enum.DB_REALTIME
                            database.child(Enum.GROUP_TABLE).child("\(nhom.id)").setValue(nhom.toDictionary()){
                            (result,error) in
                            guard error != nil else{
                                self.thongBao(message: "Chỉnh sửa thất bại!")
                                return
                            }
                            self.thongBao(message: "Chỉnh sửa thành công!")
                            }
                        }
                        
                       
                        
                    }
                    }else{
                        self.thongBao(message: "Thông tin còn thiếu!")
                    }
            }
            else{
                self.thongBao(message: "Số lượng phải là kí tự số!")
            }
        }
    }
    
    @IBOutlet weak var imageNhom: UIImageView!
    
    
    @IBOutlet weak var inputTen: UITextField!
    @IBOutlet weak var inputSoLuong: UITextField!
    
    @IBAction func chooseImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
       
        imagePicker.sourceType = .photoLibrary
        // Thuc hien uy quyen cho doi tuong imagePicker
        imagePicker.delegate = self
        // Chuyen dieu khien cho imagePicker
       
        present(imagePicker, animated: true)
    }
    
    var tenNhom = ""
    var soLuong = ""
    var anh = "NULL"
    var idUser = 15
    var status = true
    var idNhom = -1
    
    var imageLayRa:UIImage?
    var manHinh:Bool = true
    var nhomEdit:Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if manHinh{
            title = "Tạo nhóm"
        }
        else{
            title = "Chỉnh sửa"
            setDataEditNhom()
        }
        inputTen.delegate = self
        inputSoLuong.delegate = self
        getIdLienTuc()
        // Do any additional setup after loading the view.
    }
    
    func setDataEditNhom() {
        if let nhomEdit = nhomEdit{
            inputTen.text = nhomEdit.title
            inputSoLuong.text = String(nhomEdit.quantity)
            soLuong = String(nhomEdit.quantity)
            tenNhom = nhomEdit.title
            let imageUrlString = nhomEdit.image
            Enum.setImageFromURL(urlString: imageUrlString, imageView: self.imageNhom)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedName = info[.originalImage] as? UIImage else{
                   print("Khong the lay anh")
                   return
               }
                imageLayRa = selectedName
               imageNhom.image = selectedName
              
               dismiss(animated: true,completion: nil)
    }
    
    func getIdLienTuc(){
        let database = Enum.DB_REALTIME
        let groupRef = database.child(Enum.GROUP_TABLE)
        let lastElement = groupRef.queryOrderedByKey().queryLimited(toLast: 1)
        lastElement.observeSingleEvent(of: .value){
            (snapshot) in
            guard snapshot.exists() else{
                self.idNhom = 0
                return
            }
            if let lastE = snapshot.children.allObjects.first as? DataSnapshot{
                if let child = lastE.value as? NSDictionary{
                    self.idNhom = child["id"] as? Int ?? -1
                    self.idNhom += 1
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTen.resignFirstResponder()
        inputSoLuong.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case inputTen:
            tenNhom = inputTen.text ?? ""
        case inputSoLuong:
            soLuong = inputSoLuong.text ?? ""
        default:
            return
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
