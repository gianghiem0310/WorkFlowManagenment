//
//  Enum.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/22/24.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import UIKit
class Enum{
    static let ISLOGIN = "isLogin"
    
    
    static let STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
    
    static let DB_REALTIME = Database.database().reference()
    static let DB_STORAGE = Storage.storage().reference()
    // MARK: Kí tự database
    static let GROUP_TABLE = "Groups"
    static let GROUP_JOIN_TABLE = "Group_Joins"
    static let JOB_TABLE = "Jobs"
    static let JOB_NOT_COMPLETE = "Job_Not_Completes"
    static let ACCCOUNT_TABLE = "Accounts"
    static let PROFILE_TABLE = "Profiles"
    static let DEADLINE_TABLE = "Deadlines"
    static let DEADLINE_JOIN_TABLE = "Deadline_Joins"
    static let JOB_MEMBER_TABLE = "Job_Members"
    static let MEMBER_TABLE = "Members"
    static let NOTIFICATION_TABLE = "Notifications"
    // MARK: Key thông báo
    static let THAM_GIA_GROUP = 0
    static let THAM_GIA_DEADLINE = 1
    static let THAM_GIA_JOB = 2
    static let NHAC_NHO = 3
    static let XAC_NHAN_COMPLETE = 4
    static let TEXT_BINH_THUONG = 5
    static let BI_XOA_KHOI_GROUP = 6
    static let BI_XOA_KHOI_DEADLINE = 7
    static let BI_XOA_KHOI_JOB = 8
    
    // MARK: Hàm tool
    static func setImageFromURL(urlString: String,imageView:UIImageView){
        if urlString != "NULL"{
            if let imageUrl = URL(string: urlString){
                let task = URLSession.shared.dataTask(with: imageUrl){(data,response,error)in
                    if let dataa = data{
                        if let image = UIImage(data: dataa){
                            DispatchQueue.main.async {
                                imageView.image = image
                            }
                        }
                    }
                }
                task.resume()
            }
        }else{
            imageView.image = UIImage(named: "default")
        }
      
    }
    static func getCurrentDateDDMMYYYY()->String{
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy"
        let current = Date()
        return dateFormat.string(from: current)
    }
}
