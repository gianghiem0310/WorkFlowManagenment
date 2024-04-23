//
//  JobInProjectController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit

class DanhSachCongViecController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var mang = [1,2,3,4,5,6,7]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "jobInProjectCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? CongViecCell else{
            return UITableViewCell()
        }
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
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
