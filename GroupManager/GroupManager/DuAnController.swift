//
//  ProjectController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/20/24.
//

import UIKit

class DuAnController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBAction func tool(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Tạo dự án", style: .default, handler:{
            action in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Thêm thành viên", style: .default, handler:{
            action in
            self.formAdd()
        }))
        actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .destructive, handler:nil))
        present(actionSheet, animated: true, completion: nil)
    }
    func formAdd() {
        let alert = UIAlertController(title: "Thêm thành viên", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: {
            textField in
            textField.placeholder = "Nhập email"
            textField.borderStyle = .line
        })
        let cancel = UIAlertAction(title: "Huỷ", style: .destructive, handler: nil)
        let okAction = UIAlertAction(title: "Đồng ý", style: .default, handler: {
            action in
            
        })
        alert.addAction(cancel)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            choose = true
            tableView.reloadData()
        case 1:
            choose = false
            tableView.reloadData()
        default:
            choose = true
            tableView.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if choose {
            return mangProject.count
        }
        return mangMember.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if choose {
            let identifier = "projectCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? DuAnCell else{
                return UITableViewCell()
            }
            return cell
        }
        else{
            let identifier = "memberProjectCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier,for: indexPath) as? ThanhVienCell else{
                return UITableViewCell()
            }
            return cell
        }
       
       
    }
    

    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    var choose = true
    var mangProject = [1,2,3,4,5,6]
    var mangMember = [1,2,3,4,5,6]
    
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
