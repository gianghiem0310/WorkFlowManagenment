//
//  JobInProjectController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit

class DanhSachCongViecController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var idView = 0
    var ar = [1,2,3,4,5,6]
    var ar2 = [1,2,3,4]
    var ar3 = [1,2]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            idView = 0
            tableView.reloadData()
        case 1:
            idView = 1
            tableView.reloadData()
        case 2:
            idView = 2
            tableView.reloadData()
        default:
            break
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if idView == 0 {
            return ar.count
        }
        if idView == 1 {
            return ar2.count
        }
        
        return ar3.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if idView == 0 {
            let identifier = "dangCanCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? DangCanCell else{
                return UITableViewCell()
            }
            return cell
        }
        if idView == 1 {
            let identifier = "chotCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? ChotCell else{
                return UITableViewCell()
            }
            return cell
        }
  
            let identifier = "thanhVienCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? ThanhVienCell else{
                return UITableViewCell()
            }
            return cell
    }
    

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let job = CongViec(title: "Thanh cong!")
        if segue.identifier == "segueCongViec"{
            if let viewConB = segue.destination as? ChiTietCongViecController{
                viewConB.receivedData = job
            }
        }
        
    }
    

}
