//
//  CreateGroupController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase
class TaoNhomController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let quantity = Int(soLuong){
            if !tenNhom.isEmpty && !soLuong.isEmpty
                    {
                        let nhom = Group(id: idNhom, title: tenNhom, image: anh, quantity: quantity, captain: idUser, status: status)
                let database = Enum.DB_REALTIME
                database.child(Enum.GROUP_TABLE).child("\(idNhom)").setValue(nhom.toDictionary()){
                    (result,error) in
                    guard error != nil else{
                        self.thongBao(message: "Tạo nhóm thất bại!")
                        return
                    }
                    self.thongBao(message: "Tạo nhóm thành công!")
                    self.inputTen.text = ""
                    self.inputSoLuong.text = ""
                    
                        }
                    }else{
                        self.thongBao(message: "Thông tin còn thiếu!")
                    }
        }
        else{
            self.thongBao(message: "Số lượng phải là kí tự số!")
        }
    }
    
    @IBOutlet weak var imageNhom: UIImageView!
    
    
    @IBOutlet weak var inputTen: UITextField!
    @IBOutlet weak var inputSoLuong: UITextField!
    
    @IBAction func chooseImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
       
        imagePicker.sourceType = .photoLibrary
        // Thuc hien uy quyen cho doi tuong imagePicker
        imagePicker.delegate = self
        // Chuyen dieu khien cho imagePicker
       
        present(imagePicker, animated: true)
    }
    
    var tenNhom = ""
    var soLuong = ""
    var anh = "NULL"
    var idUser = 0
    var status = true
    var idNhom = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTen.delegate = self
        inputSoLuong.delegate = self
        getIdLienTuc()
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedName = info[.originalImage] as? UIImage else{
                   print("Khong the lay anh")
                   return
               }
               imageNhom.image = selectedName
              
               dismiss(animated: true,completion: nil)
    }
    
    func getIdLienTuc(){
        let database = Enum.DB_REALTIME
        database.child(Enum.GROUP_TABLE).observe(DataEventType.value){ (snapshot) in
            self.idNhom = Int(snapshot.childrenCount)
        }
    }
    
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputTen.resignFirstResponder()
        inputSoLuong.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case inputTen:
            tenNhom = inputTen.text ?? ""
        case inputSoLuong:
            soLuong = inputSoLuong.text ?? ""
        default:
            return
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
