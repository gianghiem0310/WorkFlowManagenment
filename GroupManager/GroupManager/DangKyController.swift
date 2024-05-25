//
//  RegisterController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase

class DangKyController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet weak var txtTenDangNhap: UITextField!
    
    @IBOutlet weak var txtMatKhau: UITextField!
    
    @IBOutlet weak var txtTenNguoiDung: UITextField!
    
    
    @IBOutlet weak var txtSoDienThoai: UITextField!
    
    
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var mauBtnDangKy: UIButton!
    
    var activityIndicator: UIActivityIndicatorView!

    var idAccount = -1
    var avatar = "NULL"
    var fit = 0
    
    var tenNguoiDung = ""
    var tenDangNhap = ""
    var soDienThoai = ""
    var email = ""
    var matKhau = ""
    var imageLayRa:UIImage?
    
    let storage = Enum.DB_STORAGE
 
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTenDangNhap.delegate = self
        txtMatKhau.delegate = self
        txtTenNguoiDung.delegate = self
        txtSoDienThoai.delegate = self
        txtEmail.delegate = self
        
        // Khởi tạo UIActivityIndicatorView
              activityIndicator = UIActivityIndicatorView(style: .large)
              activityIndicator.center = view.center
              activityIndicator.hidesWhenStopped = true
              view.addSubview(activityIndicator)
        
        //Ẩn bàn phím khi nhấn bất cứ đâu ở màn hinh
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGes)
 
        customGiaoDien()
        getIdLienTuc()

    }
    
    func toggleActivityIndicator(_ show: Bool) {
          if show {
              activityIndicator.startAnimating()
          } else {
              activityIndicator.stopAnimating()
          }
      }

    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
   
    
    @IBAction func tapGestureAvatar(_ sender: UITapGestureRecognizer) {
        txtTenDangNhap.resignFirstResponder()
        txtMatKhau.resignFirstResponder()
        txtTenNguoiDung.resignFirstResponder()
        txtSoDienThoai.resignFirstResponder()
        txtEmail.resignFirstResponder()
        //B3. Bat User Interaction Enabled
        //Tao doi tuong UIImagePickerController
        let imagePicker = UIImagePickerController()
        // Cau hinh cho doi tuong image
        imagePicker.sourceType = .photoLibrary
        
        //Thuc hien uy quyen cho doi tuong imagePicker
        imagePicker.delegate = self
        //Chuyen dieu khieu cho imagePicker
        present(imagePicker, animated: true)
    }
    
    @IBAction func banDaCoTaiKhoan(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginView")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    var idNew = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getIdLienTuc()
    }
    
    var checkState = true
    let database = Enum.DB_REALTIME
    
    func getIdLienTuc(){
        let groupRef = database.child(Enum.ACCCOUNT_TABLE)
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
//                    self.thongBao(message: "thay doi \(self.idNew)")
                }
            }
        }
    }
    var account:Account?
    
    @IBAction func btnDangKyTaiKhoan(_ sender: UIButton) {
        
        getIdLienTuc()
        self.toggleActivityIndicator(true)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
            
           
            if let tenDangNhap = self.txtTenDangNhap.text, let tenNguoiDung = self.txtTenNguoiDung.text, let soDienThoai = self.txtSoDienThoai.text, let email = self.txtEmail.text, let matKhau = self.txtMatKhau.text
//               ,let anh = self.imageAvatar.image
            {
                
                if !tenDangNhap.isEmpty || !tenNguoiDung.isEmpty || !soDienThoai.isEmpty ||
                    !email.isEmpty || !matKhau.isEmpty{
                    
                    if tenDangNhap.count >= 6 || matKhau.count >= 6{

                            self.database.child(Enum.ACCCOUNT_TABLE).observe(DataEventType.value){
                                snapshot in
                                
                                if snapshot.childrenCount > 0{
                                  
                                    for child in snapshot.children{

                                        if let object = child as? DataSnapshot{

                                            if let value = object.value as? NSDictionary{

                                                let tenDangNhapFb = value["username"] as? String ?? ""
                                                if tenDangNhap == tenDangNhapFb {
                                                    self.checkState = false
                                                  
                                                }
                                            }
                                        }
                                    }
                                }
                            }
  
                        DispatchQueue.main.asyncAfter(deadline: .now()+3.0){
                          
                            if self.checkState {
                                self.account = Account(id: self.idNew, username: self.tenDangNhap, password: self.matKhau)
                                if let account = self.account{
                                    self.database.child(Enum.ACCCOUNT_TABLE).child("\(self.idNew)").setValue(account.toDictionary()){
                                        (result,error) in
                                        guard error != nil else{
                                            self.thongBao(message: "Tạo tài khoản thất bại!")
                                            return
                                        }
                                       
                                        if let image = self.imageLayRa {
                                            guard let imageData = image.jpegData(compressionQuality: 0.8) else {
                                                return
                                            }
                                            let imageName = "avatar/account\(self.idNew).jpeg"
                                            let imageRef = self.storage.child("images/\(imageName)")
                                            let uploadTask = imageRef.putData(imageData,metadata: nil){
                                                (metadata, error) in imageRef.downloadURL{
                                                    (url, error) in
                                                    if let dowloadURL = url, let account = self.account{
                                                        let profile = Profile(idAccount: account.id, avatar: dowloadURL.absoluteString, name: self.tenNguoiDung, phone: self.soDienThoai, email: self.email, fit: self.fit)
                                                        
                                                        self.database.child(Enum.PROFILE_TABLE).child("\(account.id)").setValue(profile.toDictionary())
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
                                            let profile = Profile(idAccount: account.id, avatar: "NULL", name: self.tenNguoiDung, phone: self.soDienThoai, email: self.email, fit: self.fit)
                                            
                                            self.database.child(Enum.PROFILE_TABLE).child("\(account.id)").setValue(profile.toDictionary())
                                        }
                                        
                                        
                                        self.toggleActivityIndicator(false)
                                        self.thongBao(message: "Tạo tài khoản thành công!")
                                        self.txtTenNguoiDung.text! = ""
                                        self.txtEmail.text! = ""
                                        self.txtTenDangNhap.text! = ""
                                        self.txtSoDienThoai.text! = ""
                                        self.txtMatKhau.text! = ""
                                        self.checkState = true
//                                    }
                                }
                            }
                        }else{
                            self.thongBao(message: "Tên đăng nhập đã tồn tại!")
                            self.toggleActivityIndicator(false)
                            self.checkState = true
                        }
                    }
                    }else{
                        self.thongBao(message: "Tên đăng nhập và mật tối thiểu 6 ký tự!")
                        self.toggleActivityIndicator(false)
                    }
                }else{
                    self.thongBao(message: "Hãy nhập đủ các thông tin!")
                    self.toggleActivityIndicator(false)
                }
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //An ban phim
        txtTenDangNhap.resignFirstResponder()
        txtMatKhau.resignFirstResponder()
        txtTenNguoiDung.resignFirstResponder()
        txtSoDienThoai.resignFirstResponder()
        txtEmail.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //originalImage anh goc
        if let image = info[.originalImage]{
            imageAvatar.image = image as? UIImage
            imageLayRa = image as? UIImage
            
        }
        //Quay lai man hinh truoc
        dismiss(animated: true)
    }
    
    
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func customGiaoDien() {
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width / 2
        imageAvatar.clipsToBounds = true
        
        txtTenDangNhap.layer.borderColor = UIColor.gray.cgColor
        txtTenDangNhap.layer.borderWidth = 2
        txtTenDangNhap.layer.cornerRadius = 10
        txtMatKhau.layer.borderColor = UIColor.gray.cgColor
        txtMatKhau.layer.borderWidth = 2
        txtMatKhau.layer.cornerRadius = 10
        txtTenNguoiDung.layer.borderColor = UIColor.gray.cgColor
        txtTenNguoiDung.layer.borderWidth = 2
        txtTenNguoiDung.layer.cornerRadius = 10
        txtSoDienThoai.layer.borderColor = UIColor.gray.cgColor
        txtSoDienThoai.layer.borderWidth = 2
        txtSoDienThoai.layer.cornerRadius = 10
        txtEmail.layer.borderColor = UIColor.gray.cgColor
        txtEmail.layer.borderWidth = 2
        txtEmail.layer.cornerRadius = 10
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {

        switch textField {
        case txtTenDangNhap:
            tenDangNhap = txtTenDangNhap.text ?? ""
        case txtMatKhau:
            matKhau = txtMatKhau.text ?? ""
        case txtTenNguoiDung:
            tenNguoiDung = txtTenNguoiDung.text ?? ""
        case txtEmail:
            email = txtEmail.text ?? ""
        case txtSoDienThoai:
            soDienThoai = txtSoDienThoai.text ?? ""
        default:
            return
        }
    }
    
    
    
    
}
