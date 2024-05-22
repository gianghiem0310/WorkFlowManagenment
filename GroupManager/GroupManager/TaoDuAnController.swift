//
//  TaoDuAnController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/22/24.
//

import UIKit

class TaoDuAnController: UIViewController {

    var group:Group?
    var deadline:Deadline?
    var status:Bool?
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let status = status{
            if status{
                if let group = group{
                    
                }
            }else{
                if let deadline = deadline{
                    
                }
            }
        }
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
