//
//  ChiTietCongViecController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit

class ChiTietCongViecController: UIViewController {
    var receivedData:CongViec?
    

    @IBOutlet weak var containerView: UIView!
    @IBAction func changView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let viewCu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
            viewCu.willMove(toParent: nil)
            viewCu.view.removeFromSuperview()
            viewCu.removeFromParent()
            
            
            let viewMoi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController1")
            
            addChild(viewMoi)
            viewMoi.view.frame = containerView.bounds
            containerView.addSubview(viewMoi.view)
            viewMoi.didMove(toParent: self)
            if let viewMoi1 = viewMoi as? FragmentChiTietCongViecController{
                if let data = receivedData{
                    viewMoi1.tenCongViec = data.title
                    viewMoi1.ten.text = data.title
                }
            
            }
            
        case 1:
            let viewCu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController1")
            viewCu.willMove(toParent: nil)
            viewCu.view.removeFromSuperview()
            viewCu.removeFromParent()
            
            
            let viewMoi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
            addChild(viewMoi)
            viewMoi.view.frame = containerView.bounds
            containerView.addSubview(viewMoi.view)
            viewMoi.didMove(toParent: self)
        default:
            containerView.backgroundColor = .white
        }
    }
   
//    func thongBao(message: String){
//        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
//    }
    
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
