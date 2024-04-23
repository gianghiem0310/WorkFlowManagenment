//
//  CapNhapThongTinViewController.swift
//  GroupManager
//
//  Created by Nguyen Hong Phuc on 4/23/24.
//

import UIKit

class CapNhapThongTinViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageAvatar: UIImageView!
    
    @IBOutlet weak var txtTenNguoiDung: UITextField!
    
    @IBOutlet weak var txtSoDienThoai: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var mauBtnSua: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customGiaoDien()
    }
    @IBAction func tapGestureAvatar(_ sender: UITapGestureRecognizer) {
     
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //An ban phim
        txtTenNguoiDung.resignFirstResponder()
        txtSoDienThoai.resignFirstResponder()
        txtEmail.resignFirstResponder()
        return true
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //originalImage anh goc
        if let image = info[.originalImage]{
            imageAvatar.image = image as? UIImage
        }
        //Quay lai man hinh truoc
        dismiss(animated: true)
    }
    
    func customGiaoDien()  {
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width / 2
        imageAvatar.clipsToBounds = true
        
  
        txtTenNguoiDung.layer.borderColor = UIColor.gray.cgColor
        txtTenNguoiDung.layer.borderWidth = 2
        txtTenNguoiDung.layer.cornerRadius = 10
        txtSoDienThoai.layer.borderColor = UIColor.gray.cgColor
        txtSoDienThoai.layer.borderWidth = 2
        txtSoDienThoai.layer.cornerRadius = 10
        txtEmail.layer.borderColor = UIColor.gray.cgColor
        txtEmail.layer.borderWidth = 2
        txtEmail.layer.cornerRadius = 10
        
        mauBtnSua.applyGradient(colors: [UIColor(red: 0.00, green: 0.60, blue: 0.96, alpha: 1.00).cgColor,UIColor(red: 0.00, green: 0.85, blue: 0.67, alpha: 1.00).cgColor ])
        mauBtnSua.layer.cornerRadius = 10
        mauBtnSua.layer.masksToBounds = true
        
    }


}
