//
//  TaoCongViecViewController.swift
//  GroupManager
//
//  Created by Nguyen Hong Phuc on 4/25/24.
//

import UIKit

class TaoCongViecViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var txtTieuDe: UITextField!
    
    @IBOutlet weak var txtSoLuongCan: UITextField!
    
    @IBOutlet weak var txtMoTa: UITextField!
    
    @IBOutlet weak var txtDiemFit: UITextField!
    
    @IBOutlet weak var dateHanCongViec: UIDatePicker!
    
    
    @IBOutlet weak var imageNhom: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGes)
        
        
        customGiaoDien()
        
        
    }
    
    @IBAction func btnXong(_ sender: UIBarButtonItem) {
        
    }
    
   
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
      
        txtTieuDe.resignFirstResponder()
        txtMoTa.resignFirstResponder()
        txtDiemFit.resignFirstResponder()
        txtSoLuongCan.resignFirstResponder()
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
      
        imagePicker.delegate = self
       
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage]{imageNhom.image = image as? UIImage}
        dismiss(animated: true)
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtTieuDe.resignFirstResponder()
        txtSoLuongCan.resignFirstResponder()
        txtMoTa.resignFirstResponder()
        txtDiemFit.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(txtTieuDe.text!)")
    }
    
    func customGiaoDien()  {
        txtTieuDe.layer.borderColor = UIColor.gray.cgColor
        txtTieuDe.layer.borderWidth = 2
        txtTieuDe.layer.cornerRadius = 10
        txtSoLuongCan.layer.borderColor = UIColor.gray.cgColor
        txtSoLuongCan.layer.borderWidth = 2
        txtSoLuongCan.layer.cornerRadius = 10
        txtMoTa.layer.borderColor = UIColor.gray.cgColor
        txtMoTa.layer.borderWidth = 2
        txtMoTa.layer.cornerRadius = 10
        txtDiemFit.layer.borderColor = UIColor.gray.cgColor
        txtDiemFit.layer.borderWidth = 2
        txtDiemFit.layer.cornerRadius = 10
    
        dateHanCongViec.layer.borderColor = UIColor.gray.cgColor
        dateHanCongViec.layer.borderWidth = 2
        dateHanCongViec.layer.cornerRadius = 10
    
    }
    
}
