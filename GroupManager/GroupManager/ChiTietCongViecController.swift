//
//  ChiTietCongViecController.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import UIKit

class ChiTietCongViecController: UIViewController {
    var receivedData:CongViec?
    
    var job:Job?
    var idUser = 15
    var idCaptain:Int?
    @IBOutlet weak var navigation: UINavigationItem!
    
    @IBAction func menu(_ sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "Select Option", message: nil, preferredStyle: .actionSheet)
             actionSheet.addAction(UIAlertAction(title: "Tham gia", style: .default, handler:{
                    action in
                    self.thongBao(message: "Tạo công việc!")
                }))
        
        actionSheet.addAction(UIAlertAction(title: "Rời Công việc", style: .destructive, handler:{
            action in
            self.thongBao(message: "Rời Job!")
        }))
        actionSheet.addAction(UIAlertAction(title: "Huỷ", style: .destructive, handler:nil))
        present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
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
            if let viewMoi1 = viewMoi as? FragmentChiTietCongViecController,let job = job{
                
                    viewMoi1.job = job
              
                viewMoi1.nameJob.text = job.title
                viewMoi1.quantityJob.text =  "\(job.join)/\(job.quantity)"
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
            if let viewMoi1 = viewMoi as? FragmentChiTietCongViecController,let job = job{
                
                
                    viewMoi1.job = job
              
                viewMoi1.nameJob.text = job.title
                viewMoi1.quantityJob.text = "\(job.join)/\(job.quantity)"
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
   
    
   override func viewDidLoad() {
        super.viewDidLoad()
    if let job = job{
        navigation.title = job.title
    }
    let viewCu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController2")
    viewCu.willMove(toParent: nil)
    viewCu.view.removeFromSuperview()
    viewCu.removeFromParent()
    
    
    let viewMoi = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ViewController1")
    
    addChild(viewMoi)
    viewMoi.view.frame = containerView.bounds
    containerView.addSubview(viewMoi.view)
    viewMoi.didMove(toParent: self)
    if let viewMoi1 = viewMoi as? FragmentChiTietCongViecController, let job = job{
        
        
            viewMoi1.job = job
      
        viewMoi1.nameJob.text = job.title
        viewMoi1.quantityJob.text = "\(job.join)/\(job.quantity)"
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
