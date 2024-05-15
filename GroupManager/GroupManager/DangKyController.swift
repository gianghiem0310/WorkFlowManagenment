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
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        txtTenDangNhap.delegate = self
        txtMatKhau.delegate = self
        txtTenNguoiDung.delegate = self
        txtSoDienThoai.delegate = self
        txtEmail.delegate = self
        //Ẩn bàn phím khi nhấn bất cứ đâu ở màn hinh
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGes)
        
        
        
        customGiaoDien()
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getIdLienTuc()
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
    
    @IBAction func btnDangKy(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginView")
        vc.modalPresentationStyle = .overFullScreen
//       present(vc, animated: true, completion: nil)
        trangThaiKiemTra = true
        
        let dataa = Enum.DB_REALTIME
        dataa.child(Enum.PROFILE_TABLE).child("\(idNew)").child("idAccount").setValue(idNew)
       
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        //Ket thuc qua trinh soan thao ham nay se duoc goi
//        //Ham lay ten ra
//        print("\(txtTenDangNhap.text!)")
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //originalImage anh goc
        if let image = info[.originalImage]{
            imageAvatar.image = image as? UIImage
        }
        //Quay lai man hinh truoc
        dismiss(animated: true)
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
        
//        mauBtnDangKy.applyGradient(colors: [UIColor(red: 0.00, green: 0.60, blue: 0.96, alpha: 1.00).cgColor,UIColor(red: 0.00, green: 0.85, blue: 0.67, alpha: 1.00).cgColor ])
//        mauBtnDangKy.layer.cornerRadius = 10
//        mauBtnDangKy.layer.masksToBounds = true
        
        
      
    }
    
   
       func textFieldDidEndEditing(_ textField: UITextField) {
      
         
       }
    var idNew = 0
    var trangThaiKiemTra = true
    func getIdLienTuc(){
        let database = Enum.DB_REALTIME
        let groupRef = database.child(Enum.PROFILE_TABLE)
        let lastElement = groupRef.queryOrderedByKey().queryLimited(toLast: 1)
        lastElement.observeSingleEvent(of: .value){
            (snapshot) in
            guard snapshot.exists() else{
                self.idNew = 0
                return
            }
            if let lastE = snapshot.children.allObjects.first as? DataSnapshot{
                if let child = lastE.value as? NSDictionary{
                    self.idNew = child["idAccount"] as? Int ?? -1
                    self.idNew += 1
                }
            }
        }
    }
}
