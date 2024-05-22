//
//  ProfileController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase

class CaNhanController: UIViewController {
    var idUser = 1
    var nameUser = ""
    var imageUser = ""
    var phoneUser = ""
    var emailUser = ""
    let database = Enum.DB_REALTIME
    var profile:Profile?

    @IBAction func logOut(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: Enum.ISLOGIN)
        dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let des = storyboard.instantiateViewController(identifier: "loginView") as? DangNhapController{
            des.modalPresentationStyle = .fullScreen
            present(des, animated: true, completion: nil)
        }
    }
    
    
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var SDT: UILabel!
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.avatar.layer.cornerRadius = self.avatar.frame.width / 2
        self.avatar.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    //NTD
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        idUser = UserDefaults.standard.integer(forKey: "idUser")
        database.child(Enum.PROFILE_TABLE).child("\(idUser)").observe(DataEventType.value){
            (snapshot) in
            if snapshot.childrenCount>0{
                        if let snap2 = snapshot.value as? NSDictionary{
                            let id = snap2["idAccount"] as? Int ?? -1
                            let name = snap2["name"] as? String ?? ""
                            let fit = snap2["fit"] as? Int ?? -1
                            let avatar = snap2["avatar"] as? String ?? ""
                            let sdt = snap2["phone"] as? String ?? ""
                            let email = snap2["email"] as? String ?? ""
                            self.profile = Profile(idAccount: id, avatar: avatar, name: name, phone: sdt, email: email, fit: fit)
                            if let profile = self.profile{
                                self.id.text = "ID: \(profile.idAccount)"
                                self.Name.text = "Tên: \(profile.name)"
                                self.SDT.text = "SĐT: \(profile.phone)"
                                self.email.text = "Email: \(profile.email)"
                                Enum.setImageFromURL(urlString: avatar, imageView: self.avatar)
                            }
                        }
        }
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
