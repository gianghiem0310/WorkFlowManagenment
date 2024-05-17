//
//  ThanhVienCongViecController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit


class FragmentThanhVienCongViecController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let array = [Profile]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Sai
//        let cell = tableView.dequeueReusableCell(withIdentifier: "thanhVienCongViecCell") as! ThanhVienCongViecCell
//
//        let item = array[indexPath.item]
//
//        cell.imageAvatar = UIImageView(image: UIImage(named: item.avatar))
//        cell.name.text = item.name
//        cell.trangThai.text = item.trangThai
        //Sai
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "thanhVienCongViecCell",for: indexPath) as? ThanhVienCongViecCell else{
            return UITableViewCell()
        }
        let child = array[indexPath.row]
        Enum.setImageFromURL(urlString: child.avatar, imageView: cell.imageAvatar)
        cell.name.text = child.name
        cell.trangThai.text = "Hoàn thành"
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    //Nghiem set Du Lieu G
    
    //End

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
