//
//  GroupController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

class NhomController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var mang = ["A","B","C","D"]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "groupCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? NhomCell else{
            return UITableViewCell()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit"){action,indexPath in
            let storyboard = Enum.STORYBOARD
            if let des = storyboard.instantiateViewController(identifier: "taoNhom") as? TaoNhomController{
                des.title = "Sửa dự án"
                let navigation = UINavigationController(rootViewController: des)
                 navigation.modalPresentationStyle = .fullScreen
                 self.present(navigation, animated: true, completion: nil)
            }
          
            
        }
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){action,indexPathN in
            self.mang.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [editAction,deleteAction]
    }
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    // Override to support conditional editing of the table view.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  
    
    

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
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
