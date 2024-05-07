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
                
                
                    viewMoi1.job = job
              
                viewMoi1.nameJob.text = job.title
                viewMoi1.quantityJob.text = String(job.quantity)
                viewMoi1.deadlineJob.text = job.deadline
                viewMoi1.fitJob.text = "Điểm tích luỹ: \(job.point) fit"
                viewMoi1.descriptionJob.text = job.description
                Enum.setImageFromURL(urlString: job.image, imageView: viewMoi1.imageJob)
                    
                
                
            
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
                
                
                    viewMoi1.job = job
              
                viewMoi1.nameJob.text = job.title
                viewMoi1.quantityJob.text = String(job.quantity)
                viewMoi1.deadlineJob.text = job.deadline
                viewMoi1.fitJob.text = "Điểm tích luỹ: \(job.point) fit"
                viewMoi1.descriptionJob.text = job.description
                Enum.setImageFromURL(urlString: job.image, imageView: viewMoi1.imageJob)
                    
                
                
            
            }
        }
    }
    
    func thongBao(message: String){
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    var job:Job = Job(id: 0, idDeadline: 1, title: "Công Việc Back-end Web", image: "https://static-xf1.vietnix.vn/wp-content/uploads/2021/01/Back-end.jpg", quantity: 20, description: "Công việc đòi hỏi kỹ năng cao trong việc giải các thuật toán logic và nặng tính chính trị trong luận văn hay nhungữ yêu cầu vốn sinh ra để giải đáp@!s", deadline: "Ngày 24 tháng 5 năm 2024", point: 20, titleDeadline: "Ngày 24 tháng 4 năm 2024", titleGroup: "Nhóm Công Việc ", status: true,join: 1)
    var idUser = 15
    
   override func viewDidLoad() {
        super.viewDidLoad()
    title = job.title
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
        
        
            viewMoi1.job = job
      
        viewMoi1.nameJob.text = job.title
        viewMoi1.quantityJob.text = String(job.quantity)
        viewMoi1.deadlineJob.text = job.deadline
        viewMoi1.fitJob.text = "Điểm tích luỹ: \(job.point) fit"
        viewMoi1.descriptionJob.text = job.description
        Enum.setImageFromURL(urlString: job.image, imageView: viewMoi1.imageJob)
            
        
        
    
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
