//
//  ThanhVienCongViecController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit

struct thanhVien {
    var avatar:String
    var name:String
    var trangThai:String
}

class FragmentThanhVienCongViecController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let array = [thanhVien(avatar: "default", name: "Nguyen Van Bi", trangThai: "hoan thanh"),thanhVien(avatar: "default", name: "Nguyen Van Bi", trangThai: "hoan thanh"),thanhVien(avatar: "default", name: "Nguyen Van Bi", trangThai: "hoan thanh"),thanhVien(avatar: "default", name: "Nguyen Van Bi", trangThai: "hoan thanh")]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thanhVienCongViecCell") as! ThanhVienCongViecCell
        
        let item = array[indexPath.item]
        
        cell.imageAvatar = UIImageView(image: UIImage(named: item.avatar))
        cell.name.text = item.name
        cell.trangThai.text = item.trangThai

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
