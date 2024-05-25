//
//  TaoDuAnController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/22/24.
//

import UIKit
import FirebaseDatabase

class TaoDuAnController: UIViewController,UITextFieldDelegate {
    var database = Enum.DB_REALTIME
    var group:Group?
    var deadline:Deadline?
    var status:Bool?
    var idNew = 0
    var duAnNew:Deadline?
    
    
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var quantity: UITextField!
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Xong(_ sender: UIBarButtonItem) {
        let datePicker = date.date
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let dateDuAnNew = dateFormat.string(from: datePicker)
      
        var sl = 0
        if let sl1 = quantity.text {
            sl = Int(sl1) ?? -1
        }
        //tao du an moi
       
        if let status = status, let group = group{
            if status{
                getIdLienTuc()
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                    self.duAnNew = Deadline(id: self.idNew, idGroup: group.id, deadline: dateDuAnNew, quantity: sl, status: true, join: 0)
                    if let duAnNew = self.duAnNew{
                        self.database.child(Enum.DEADLINE_TABLE).child("\(group.id)").child("\(self.idNew)").setValue(duAnNew.toDictionary()){
                        (result,error) in
                        guard error != nil else{
                            self.thongBao(message: "Tạo dự án thất bại!")
                            return
                        }
                        self.thongBao(message: "Tạo dự án thành công!")
                        }
                    }
                    
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        quantity.delegate = self
        if let group = group{
            nameGroup.text = group.title
        }
        }
    
    func getIdLienTuc(){
        let database = Enum.DB_REALTIME
        if let group = group{
            let groupRef = database.child(Enum.DEADLINE_TABLE).child("\(group.id)")
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
                    }
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        quantity.resignFirstResponder()
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
