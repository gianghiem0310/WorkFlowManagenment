//
//  DoiMatKhauController.swift
//  GroupManager
//
//  Created by sakurashi on 2/8/1403 AP.
//

import UIKit
import FirebaseDatabase

class DoiMatKhauController: UIViewController ,UITextFieldDelegate{
    
    var idUser = 1
    let database = Enum.DB_REALTIME
    @IBOutlet weak var txtMatKhau: UITextField!
    @IBOutlet weak var txtXacNhanMatKhau: UITextField!
    @IBAction func btnXong(_ sender: UIBarButtonItem) {
        if let matKhaumoi = txtMatKhau.text,let xacNhanMatKhauMoi = txtXacNhanMatKhau.text{
            if !matKhaumoi.isEmpty || !xacNhanMatKhauMoi.isEmpty{
                if matKhaumoi == xacNhanMatKhauMoi{
                    database.child(Enum.ACCCOUNT_TABLE).child("\(idUser)").child("password").setValue(matKhaumoi)
                    thongBao(message: "Mat khau moi da dc thay doi")
                    txtMatKhau.text = ""
                    txtXacNhanMatKhau.text = ""
                }else{
                    thongBao(message: "Mat khau khong giong nhau")
                }
            }else{
                thongBao(message: "Mat Khau Khong Duoc De Trong")
            }
        }
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMatKhau.delegate = self
        txtXacNhanMatKhau.delegate = self
        customGiaoDien()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.setValue(1, forKey: "idUser")
        UserDefaults.standard.synchronize()
        idUser = UserDefaults.standard.integer(forKey: "idUser")
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    func customGiaoDien()  {
        txtMatKhau.layer.borderColor = UIColor.gray.cgColor
        txtMatKhau.layer.borderWidth = 2
        txtMatKhau.layer.cornerRadius = 5
        
        txtXacNhanMatKhau.layer.borderColor = UIColor.gray.cgColor
        txtXacNhanMatKhau.layer.borderWidth = 2
        txtXacNhanMatKhau.layer.cornerRadius = 5
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtMatKhau.resignFirstResponder()
        txtXacNhanMatKhau.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    print("\(txtMatKhau.text!)")
    print("\(txtXacNhanMatKhau.text!)")
    }
    
  

}
