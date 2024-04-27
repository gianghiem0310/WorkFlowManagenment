//
//  LoginController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

class DangNhapController: UIViewController {

    
    @IBAction func btnLogin(_ sender: UIButton) {
       
        
        UserDefaults.standard.setValue(true, forKey: Enum.ISLOGIN)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let des = storyboard.instantiateViewController(identifier: "DisplayManager") as? DisplayManagerController{
            des.modalPresentationStyle = .fullScreen
            present(des, animated: true, completion: nil)
        }
        
    }
    
    @IBOutlet weak var logoApp: UIImageView!
    
    @IBOutlet weak var tenDangNhap: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        logoApp.layer.cornerRadius = logoApp.frame.width / 2

        // Do any additional setup after loading the view.
        if UserDefaults.standard.bool(forKey: "isLogin"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let des = storyboard.instantiateViewController(identifier: "DisplayManager") as? DisplayManagerController{
                des.modalPresentationStyle = .fullScreen
                present(des, animated: true, completion: nil)
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

