//
//  LoginController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class DangNhapController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var txtTenDangNhap: UITextField!
    
    @IBOutlet weak var txtMatKhau: UITextField!
    
    
    
    @IBOutlet weak var mauBtnLogin: UIButton!
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtTenDangNhap.delegate = self
        txtMatKhau.delegate = self
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGes)
        
        // Khởi tạo UIActivityIndicatorView
              activityIndicator = UIActivityIndicatorView(style: .large)
              activityIndicator.center = view.center
              activityIndicator.hidesWhenStopped = true
              view.addSubview(activityIndicator)
        
        
        if UserDefaults.standard.bool(forKey: "isLogin"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let des = storyboard.instantiateViewController(identifier: "DisplayManager") as? DisplayManagerController{
                des.modalPresentationStyle = .fullScreen
                present(des, animated: true, completion: nil)
            }
        }
        customGiaoDien()
        
    }
    func toggleActivityIndicator(_ show: Bool) {
          if show {
              activityIndicator.startAnimating()
          } else {
              activityIndicator.stopAnimating()
          }
      }
    
    var tenDangNhap = ""
    var matKhau = ""
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtTenDangNhap.resignFirstResponder()
        txtMatKhau.resignFirstResponder()
        return true
    }
    
    
    let db = Enum.DB_REALTIME
    
    var checkIsLogin = false
    var idUser = -1
    
    @IBAction func btnLogin(_ sender: UIButton) {
        self.toggleActivityIndicator(true)
        if let txtTenDangNhap = txtTenDangNhap , let txtMatKhau = txtMatKhau{
            if let ten = txtTenDangNhap.text, let matKhau = txtMatKhau.text{
                if !ten.isEmpty || !matKhau.isEmpty{
                    
                    db.child(Enum.ACCCOUNT_TABLE).observe(DataEventType.value){
                        snapshot in
                        if snapshot.childrenCount > 0{
                            self.checkIsLogin = false
                            for child in snapshot.children{
                                
                                if let object = child as? DataSnapshot{
                                    
                                    if let value = object.value as? NSDictionary{
                                        
                                        let tenDangNhapFb = value["username"] as? String ?? ""
                                        let matKhauFb = value["password"] as? String ?? ""

                                        if ten == tenDangNhapFb && matKhau == matKhauFb{
                                            self.checkIsLogin = true
                                            self.idUser = value["id"] as? Int ?? -1
                                            
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                        }
                        
                    }
               
                    toggleActivityIndicator(true)
                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                        if self.checkIsLogin{
                            self.db.child(Enum.PROFILE_TABLE).child("\(self.idUser)").observe(DataEventType.value){
                                snap in
                                if let value = snap.value as? NSDictionary{
                                    let id = value["idAccount"] as? Int ?? -1
                                    let ten = value["name"] as? String ?? ""
                                    let avatar = value["avatar"] as? String ?? ""
                                    
                                    UserDefaults.standard.setValue(id, forKey: "idUser")
                                    UserDefaults.standard.setValue(ten, forKey: "nameUser")
                                    UserDefaults.standard.setValue(avatar, forKey: "imageUser")
                                    
                                    UserDefaults.standard.setValue(true, forKey: Enum.ISLOGIN)
                                    UserDefaults.standard.synchronize()
                                    
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    if let des = storyboard.instantiateViewController(identifier: "DisplayManager") as? DisplayManagerController{
                                        des.modalPresentationStyle = .fullScreen
                                        self.present(des, animated: true, completion: nil)
                                    }
                                }
                            }
                            
                        }else{
                            self.toggleActivityIndicator(false)
                            self.thongBao(message: "Tên đăng nhập hoặc mật khẩu không đúng!")
                        }
                    
                    }
                }else{
                    toggleActivityIndicator(false)
                    thongBao(message: "Chưa nhập tài khoản hoặc mật khẩu!")
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
    
    
    @IBAction func btnQuenMatKhau(_ sender: UIButton) {
    }
    
    @IBAction func btnDangKyTaiKhoan(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signup")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    
    func customGiaoDien(){
        imageLogo.layer.cornerRadius = imageLogo.frame.size.width / 2
        imageLogo.clipsToBounds = true
        
        txtTenDangNhap.layer.borderColor = UIColor.gray.cgColor
        txtTenDangNhap.layer.borderWidth = 2
        txtTenDangNhap.layer.cornerRadius = 10
        
        
        txtMatKhau.layer.borderColor = UIColor.gray.cgColor
        txtMatKhau.layer.borderWidth = 2
        txtMatKhau.layer.cornerRadius = 10
        
        
    }
}
