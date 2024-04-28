//
//  CapNhatThongTinController.swift
//  GroupManager
//
//  Created by sakurashi on 2/8/1403 AP.
//

import UIKit

class CapNhatThongTinController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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

}
