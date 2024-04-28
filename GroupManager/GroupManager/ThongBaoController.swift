//
//  NotificationController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

struct thongBao {
    var tenDeTai:String
    var tenNhom:String
    var ngayHetHan:String
    var tinhTrang:String
    var thongBao:String
    var hinh:String
}

class ThongBaoController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var thongBaoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let array = [thongBao(tenDeTai: "bachend", tenNhom: "DeadLine", ngayHetHan: "ngay:16/7/2024", tinhTrang: "sap hoan thanh", thongBao: "Nhắc bạn sắp đến hạn nộp ", hinh: "default"),thongBao(tenDeTai: "bachend", tenNhom: "DeadLine", ngayHetHan: "ngay:16/7/2024", tinhTrang: "sap hoan thanh", thongBao: "", hinh: "logoApp"),thongBao(tenDeTai: "bachend", tenNhom: "DeadLine", ngayHetHan: "ngay:16/7/2024", tinhTrang: "sap hoan thanh", thongBao: "Nhắc bạn sắp đến hạn nộp ", hinh: "logoApp"),thongBao(tenDeTai: "bachend", tenNhom: "DeadLine", ngayHetHan: "ngay:16/7/2024", tinhTrang: "sap hoan thanh", thongBao: "", hinh: "default")]

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "thongBaoCell") as! ThongBaoCell
        
        let item = array[indexPath.item]
        
        cell.hinh.image = UIImage(named: item.hinh)
        cell.tenDoAn.text = item.tenDeTai
        cell.tenNhom.text = item.tenNhom
        cell.Ngay.text = item.ngayHetHan
        cell.tinhTrang.text = item.tinhTrang
        cell.thongBao.text = item.thongBao
        
        return cell
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
