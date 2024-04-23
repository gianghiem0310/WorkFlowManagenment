//
//  CongViecViewController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit

class FragmentChiTietCongViecController: UIViewController {

    var tenCongViec:String = ""
    @IBOutlet weak var ten: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       thongBao(message: tenCongViec)
        // Do any additional setup after loading the view.
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
