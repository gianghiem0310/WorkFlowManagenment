//
//  ProfileController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

class CaNhanController: UIViewController {

    @IBAction func logOut(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: Enum.ISLOGIN)
        dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let des = storyboard.instantiateViewController(identifier: "loginView") as? DangNhapController{
            des.modalPresentationStyle = .fullScreen
            present(des, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
