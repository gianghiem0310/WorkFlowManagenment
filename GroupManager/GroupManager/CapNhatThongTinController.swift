//
//  CapNhatThongTinController.swift
//  GroupManager
//
//  Created by sakurashi on 2/8/1403 AP.
//

import UIKit
import FirebaseDatabase

class CapNhatThongTinController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var idUser = 1
    let database = Enum.DB_REALTIME
    var profile:Profile?
    let storage = Enum.DB_STORAGE
    var HinhMoi:UIImage?
    @IBAction func btn_Xong(_ sender: UIBarButtonItem) {
        if let name = txtTenNguoiDung.text,let sdt = txtSDT.text, let email = txtEmail.text{
            if !name.isEmpty || !sdt.isEmpty || !email.isEmpty {
                    if let image = HinhMoi {
                        guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
                        let imageName = "avatar\(idUser).jpeg"
                        let imageRef = storage.child("images/\(imageName)")
                        let uploadTask = imageRef.putData(imageData,metadata: nil){(metadata,error) in
                        imageRef.downloadURL{ (url,eror) in
                            guard let downloadURL = url else{ return }
                            self.database.child(Enum.PROFILE_TABLE).child("\(self.idUser)").child("avatar").setValue(downloadURL.absoluteString)
                        }
                        }
                        uploadTask.observe(.success){
                            snap in
                            self.database.child(Enum.PROFILE_TABLE).child("\(self.idUser)").child("name").setValue(name)
                            self.database.child(Enum.PROFILE_TABLE).child("\(self.idUser)").child("email").setValue(email)
                            self.database.child(Enum.PROFILE_TABLE).child("\(self.idUser)").child("phone").setValue(sdt)
                            UserDefaults.standard.setValue(self.idUser, forKey: "idUser")
                            UserDefaults.standard.setValue(name, forKey: "nameUser")
                            UserDefaults.standard.setValue(self.imageAvatar.image, forKey: "imageUser")
                            UserDefaults.standard.setValue(sdt, forKey: "phoneUser")
                            UserDefaults.standard.setValue(email, forKey: "emailUser")
                            UserDefaults.standard.synchronize()
                            self.thongBao(message: "Cap nhat thanh cong")
                        }
                }else{
                    database.child(Enum.PROFILE_TABLE).child("\(idUser)").child("name").setValue(name)
                    database.child(Enum.PROFILE_TABLE).child("\(idUser)").child("email").setValue(email)
                    database.child(Enum.PROFILE_TABLE).child("\(idUser)").child("phone").setValue(sdt)
                    thongBao(message: "Cap nhat thanh cong")
                }
            }else{
                thongBao(message: "khong dupc de trong")
            }
        }
    }
    
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var txtTenNguoiDung: UITextField!
    @IBOutlet weak var txtSDT: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTenNguoiDung.delegate = self
        txtSDT.delegate = self
        txtEmail.delegate = self
        customGiaoDien()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        idUser = UserDefaults.standard.integer(forKey: "idUser")
        database.child(Enum.PROFILE_TABLE).child("\(idUser)").observe(DataEventType.value){
            (snapshot) in
            if snapshot.childrenCount>0{
                        if let snap2 = snapshot.value as? NSDictionary{
                            let id = snap2["idAccount"] as? Int ?? -1
                            let name = snap2["name"] as? String ?? ""
                            let fit = snap2["fit"] as? Int ?? -1
                            let avatar = snap2["avatar"] as? String ?? ""
                            let sdt = snap2["phone"] as? String ?? ""
                            let email = snap2["email"] as? String ?? ""
                            self.profile = Profile(idAccount: id, avatar: avatar, name: name, phone: sdt, email: email, fit: fit)
                            if let profile = self.profile{
                                Enum.setImageFromURL(urlString: profile.avatar, imageView: self.imageAvatar)
                                self.txtTenNguoiDung.text = profile.name
                                self.txtEmail.text = profile.email
                                self.txtSDT.text = profile.phone
                            }
                        }
        }
        }
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        txtTenNguoiDung.resignFirstResponder()
        txtSDT.resignFirstResponder()
        txtEmail.resignFirstResponder()
                // Tao doi tuong UIImgePickerController
                let imagePicker = UIImagePickerController()
                // Cau hinh cho doi tuong imagePicker
                imagePicker.sourceType = .photoLibrary
                // Thuc hien uy quyen cho doi tuong imagePicker
                imagePicker.delegate = self
                // Chuyen dieu khien cho imagePicker
                present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] {
                //ep kieu
                imageAvatar.image = image as? UIImage
                HinhMoi = image as? UIImage
            }
            //Quay lai man hinh truoc do
            dismiss(animated: true)
        }
    
    func customGiaoDien()  {
        imageAvatar.layer.cornerRadius = imageAvatar.frame.width / 2
        imageAvatar.layer.masksToBounds = true
        
        txtTenNguoiDung.layer.borderColor = UIColor.gray.cgColor
        txtTenNguoiDung.layer.borderWidth = 2
        txtTenNguoiDung.layer.cornerRadius = 5
        
        txtSDT.layer.borderColor = UIColor.gray.cgColor
        txtSDT.layer.borderWidth = 2
        txtSDT.layer.cornerRadius = 5
        
        txtEmail.layer.borderColor = UIColor.gray.cgColor
        txtEmail.layer.borderWidth = 2
        txtEmail.layer.cornerRadius = 5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtTenNguoiDung.resignFirstResponder()
        txtSDT.resignFirstResponder()
        txtEmail.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    print("\(txtTenNguoiDung.text!)")
    print("\(txtSDT.text!)")
    print("\(txtEmail.text!)")
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}
