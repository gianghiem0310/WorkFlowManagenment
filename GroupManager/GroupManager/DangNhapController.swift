//
//  LoginController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

class DangNhapController: UIViewController {

    @IBOutlet weak var imageLogo: UIImageView!
    
    @IBOutlet weak var txtTenDangNhap: UITextField!
    
    @IBOutlet weak var txtMatKhau: UITextField!
    
    
    
    @IBOutlet weak var mauBtnLogin: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UserDefaults.standard.bool(forKey: "isLogin"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let des = storyboard.instantiateViewController(identifier: "DisplayManager") as? DisplayManagerController{
                des.modalPresentationStyle = .fullScreen
                present(des, animated: true, completion: nil)
            }
        }
        customGiaoDien()
        
    }
    
    
   
    @IBAction func btnLogin(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: Enum.ISLOGIN)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let des = storyboard.instantiateViewController(identifier: "DisplayManager") as? DisplayManagerController{
            des.modalPresentationStyle = .fullScreen
            present(des, animated: true, completion: nil)
        }
    }
    

    @IBAction func btnQuenMatKhau(_ sender: UIButton) {
    }
    
    @IBAction func btnDangKyTaiKhoan(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signup")
        vc.modalPresentationStyle = .overFullScreen
       present(vc, animated: true, completion: nil)
    }
    
    func customGiaoDien(){
        imageLogo.layer.cornerRadius = imageLogo.frame.size.width / 2
        imageLogo.clipsToBounds = true
        
        txtTenDangNhap.layer.borderColor = UIColor.gray.cgColor
        txtTenDangNhap.layer.borderWidth = 2
        txtTenDangNhap.layer.cornerRadius = 10
        

        txtMatKhau.layer.borderColor = UIColor.gray.cgColor
        txtMatKhau.layer.borderWidth = 2
        txtMatKhau.layer.cornerRadius = 10
        
        mauBtnLogin.applyGradient(colors: [UIColor(red: 0.00, green: 0.60, blue: 0.96, alpha: 1.00).cgColor,UIColor(red: 0.00, green: 0.85, blue: 0.67, alpha: 1.00).cgColor ])
        mauBtnLogin.layer.cornerRadius = 10
        mauBtnLogin.layer.masksToBounds = true
        
//        let gradi = CAGradientLayer()
//        gradi.colors = [UIColor.systemOrange.cgColor,
//                        UIColor.systemYellow.cgColor]
//        gradi.frame = mauBtnLogin.bounds
//        mauBtnLogin.layer.insertSublayer(gradi, at: 0)
//        mauBtnLogin.layer.cornerRadius = 10
//        mauBtnLogin.layer.masksToBounds = true
        
    }
 

}

extension UIButton {
    func applyGradient(colors : [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = layer.cornerRadius
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
}

