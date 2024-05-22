//
//  DoiMatKhauController.swift
//  GroupManager
//
//  Created by sakurashi on 2/8/1403 AP.
//

import UIKit

class DoiMatKhauController: UIViewController ,UITextFieldDelegate{

    
    @IBOutlet weak var txtMatKhau: UITextField!
    @IBOutlet weak var txtXacNhanMatKhau: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMatKhau.delegate = self
        txtXacNhanMatKhau.delegate = self
        customGiaoDien()
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
