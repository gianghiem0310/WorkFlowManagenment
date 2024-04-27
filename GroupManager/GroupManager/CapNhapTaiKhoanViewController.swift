//
//  CapNhapTaiKhoanViewController.swift
//  GroupManager
//
//  Created by Nguyen Hong Phuc on 4/23/24.
//

import UIKit

class CapNhapTaiKhoanViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var mauBtnDoiMatKhau: UIButton!
    @IBOutlet weak var txtNhapLaiMatKhau: UITextField!
    @IBOutlet weak var txtMatKhauMoi: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        customGiaoDien()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //An ban phim
        txtMatKhauMoi.resignFirstResponder()
        txtNhapLaiMatKhau.resignFirstResponder()
        return true
    }
    
    
    @IBAction func btnDoiMatKhau(_ sender: UIButton) {
    }
    
    func customGiaoDien() {
        
        txtMatKhauMoi.layer.borderColor = UIColor.gray.cgColor
        txtMatKhauMoi.layer.borderWidth = 2
        txtMatKhauMoi.layer.cornerRadius = 10
        
        txtNhapLaiMatKhau.layer.borderColor = UIColor.gray.cgColor
        txtNhapLaiMatKhau.layer.borderWidth = 2
        txtNhapLaiMatKhau.layer.cornerRadius = 10
        
        mauBtnDoiMatKhau.applyGradient(colors: [UIColor(red: 0.00, green: 0.60, blue: 0.96, alpha: 1.00).cgColor,UIColor(red: 0.00, green: 0.85, blue: 0.67, alpha: 1.00).cgColor ])
        mauBtnDoiMatKhau.layer.cornerRadius = 10
        mauBtnDoiMatKhau.layer.masksToBounds = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
   
      
    }

}
