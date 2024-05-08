//
//  ProfileController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit
import FirebaseDatabase

class CaNhanController: UIViewController {
    var idUser = 0
    var nameUser = ""
    var imageUser = ""
    var phoneUser = ""
    var emailUser = ""

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
        UserDefaults.standard.setValue(1, forKey: "idUser")
        UserDefaults.standard.setValue("Thai", forKey: "nameUser")
        UserDefaults.standard.setValue("https://sm.ign.com/ign_nordic/cover/a/avatar-gen/avatar-generations_prsz.jpg", forKey: "imageUser")
        UserDefaults.standard.setValue("012234556789", forKey: "phoneUser")
        UserDefaults.standard.setValue("taodeptrai@mail.com", forKey: "emailUser")
        UserDefaults.standard.synchronize()
        idUser = UserDefaults.standard.integer(forKey: "idUser")
        nameUser = UserDefaults.standard.string(forKey: "nameUser") ?? ""
        imageUser = UserDefaults.standard.string(forKey: "imageUser") ?? ""
        phoneUser = UserDefaults.standard.string(forKey: "phoneUser") ?? ""
        emailUser = UserDefaults.standard.string(forKey: "emailUser") ?? ""
        
        id.text = "\(idUser)"
        Name.text = nameUser
        Enum.setImageFromURL(urlString: imageUser, imageView: avatar)
        SDT.text = phoneUser
        email.text = emailUser
        
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
