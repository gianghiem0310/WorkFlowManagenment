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
    // MARK: Hàm có liên quan đến thông báo
    static func guiLoiMoiThamGiaGroup(notification:Notification){
        DB_REALTIME.child(Enum.NOTIFICATION_TABLE)
            .child("\(notification.idReceiver)")
            .child("\(notification.idSender)")
            .child("\(notification.id)")
            .setValue(notification.toDictionary())
    }
    static func xoaThanhVienGroup(notification:Notification){
        DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(notification.idReceiver)").child("\(notification.idSender)").child("\(notification.id)").setValue(notification.toDictionary())
        var kiemTra = true
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
            
            DB_REALTIME.child(Enum.GROUP_TABLE).child("\(notification.idGroup)").observe(DataEventType.value){
                snap in
                
                if snap.childrenCount > 0 && kiemTra{
                    if let child = snap.value as? NSDictionary{
                        let join = child["join"] as? Int ?? -1
                        DB_REALTIME.child(Enum.GROUP_TABLE).child("\(notification.idGroup)").child("join").setValue(join-1)
                        kiemTra = false
                    }
                }
            }
        }
        
    }
    static func xoaThanhVienDeadline(profileMember:Profile,deadline:Deadline,idCaptain:Int,closure: @escaping ()->Void){
        var trangThaiKiemTra = true
        var check = true
        if trangThaiKiemTra {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                if trangThaiKiemTra {
                    var idNewNoti = 0
                    DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(profileMember.idAccount)").child("\(idCaptain)").observe(DataEventType.value){
                        snapshot in
                        if trangThaiKiemTra == true{
                            let content = "Bạn bị xoá khỏi project \(deadline.deadline)!"
                            let date = Enum.getCurrentDateDDMMYYYY()
                            let notification = Notification(id:Int(snapshot.childrenCount),idSender: idCaptain, idReceiver: profileMember.idAccount, content: content, type: Enum.BI_XOA_KHOI_DEADLINE, idGroup: deadline.idGroup, idDeadline: deadline.id, idJob: -1, date: date)
                            DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(notification.idReceiver)").child("\(notification.idSender)").child("\(notification.id)").setValue(notification.toDictionary())
                            DB_REALTIME.child(Enum.DEADLINE_JOIN_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)").child("\(profileMember.idAccount)").removeValue()
                            DB_REALTIME.child(Enum.DEADLINE_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)").observe(DataEventType.value){
                                snaphot in
                                if snaphot.childrenCount > 0,check{
                                        if let child = snaphot.value as? NSDictionary{
                                            let join = child["join"] as? Int ?? -1
                                            DB_REALTIME.child(Enum.DEADLINE_TABLE).child("\(deadline.idGroup)").child("\(deadline.id)").child("join").setValue(join-1)
                                            trangThaiKiemTra = false
                                            check = false
                                            closure()
                                        }
                                }
                            }
                            
                            
                            
                            trangThaiKiemTra = false
                        }
                        trangThaiKiemTra = false
                    }
                    
                    
                    
                    
                }
            }
        }
        
    }
    static func xoaThanhVienJob(profileMember:Profile,idGroup:Int,job:Job,idCaptain:Int,closure: @escaping ()->Void){
        var trangThaiKiemTra = true
        var check = true
        if trangThaiKiemTra {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5){
                if trangThaiKiemTra {
                    var idNewNoti = 0
                    DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(profileMember.idAccount)").child("\(idCaptain)").observe(DataEventType.value){
                        snapshot in
                        if trangThaiKiemTra == true{
                            let content = "Bạn bị xoá khỏi Công việc \(job.title)!"
                            let date = Enum.getCurrentDateDDMMYYYY()
                            let notification = Notification(id:Int(snapshot.childrenCount),idSender: idCaptain, idReceiver: profileMember.idAccount, content: content, type: Enum.BI_XOA_KHOI_JOB, idGroup: idGroup, idDeadline: job.idDeadline, idJob: job.id, date: date)
                            DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(notification.idReceiver)").child("\(notification.idSender)").child("\(notification.id)").setValue(notification.toDictionary())
                            DB_REALTIME.child(Enum.JOB_MEMBER_TABLE).child("\(idGroup)").child("\(job.idDeadline)").child("\(job.id)").child("\(profileMember.idAccount)").removeValue()
                            DB_REALTIME.child(Enum.JOB_NOT_COMPLETE).child("\(profileMember.idAccount)").child("\(idGroup)").child("\(job.idDeadline)").child("\(job.id)").removeValue()
                            DB_REALTIME.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(job.idDeadline)").child("\(job.id)").observe(DataEventType.value){
                                snaphot in
                                if snaphot.childrenCount > 0,check{
                                        if let child = snaphot.value as? NSDictionary{
                                            let join = child["join"] as? Int ?? -1
                                            DB_REALTIME.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(job.idDeadline)").child("\(job.id)").child("join").setValue(join-1)
                                            trangThaiKiemTra = false
                                            check = false
                                            closure()
                                        }
                                }
                            }
                            
                            
                            
                            trangThaiKiemTra = false
                        }
                        trangThaiKiemTra = false
                    }
                    
                    
                    
                    
                }
            }
        }
    }
    static func xinVaoDeadline(notification:Notification){
        
    }
    static func xinVaoJob(notification:Notification){
        
    }
    static func yeuCauXacNhanHoanThanhCongViec(notification:Notification){
        
    }
    static func roiGroup(idReceiver:Int,idSender:Int,content:String,idGroup:Int,closure: @escaping ()->Void){
        var kiemTra = true
        var idNew = 0
        //Duyệt để lấy id thông báo mới nhất
        DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(idReceiver)").child("\(idSender)").observe(DataEventType.value){
            snapshot in
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                if kiemTra {
                    idNew = Int(snapshot.childrenCount)
                    let noti = Notification(id: idNew, idSender: idSender, idReceiver: idReceiver, content: content, type: Enum.TEXT_BINH_THUONG, idGroup: idGroup, idDeadline: -1, idJob: -1, date: Enum.getCurrentDateDDMMYYYY())
                    DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(idReceiver)").child("\(idSender)").child("\(noti.id)").setValue(noti.toDictionary())
                    DB_REALTIME.child(Enum.MEMBER_TABLE).child("\(idGroup)").child("\(idSender)").removeValue()
                    DB_REALTIME.child(Enum.GROUP_TABLE).child("\(idGroup)")
                        .observe(DataEventType.value){
                            snapshot1 in
                            if kiemTra {
                            if snapshot1.childrenCount>0{
                                if let value = snapshot1.value as? NSDictionary{
                                    let join = value["join"] as? Int ?? -1
                                        DB_REALTIME.child(Enum.GROUP_JOIN_TABLE).child("\(idSender)").child("\(idGroup)").removeValue()
                                    DB_REALTIME.child(Enum.GROUP_TABLE).child("\(idGroup)").child("join").setValue(join-1)
                                    kiemTra = false
                                    DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                                       
                                        closure()
                                    }
                                    }
                                        
                                    
                                }
                            }
                        }
                }
            }
        }
    }
    static func roiDeadline(idReceiver:Int,idSender:Int,content:String,idGroup:Int,idDeadline:Int){
        var kiemTra = true
        var idNew = 0
        //Duyệt để lấy id thông báo mới nhất
        DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(idReceiver)").child("\(idSender)").observe(DataEventType.value){
            snapshot in
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                if kiemTra {
                    if idSender != idReceiver{
                        idNew = Int(snapshot.childrenCount)
                        let noti = Notification(id: idNew, idSender: idSender, idReceiver: idReceiver, content: content, type: Enum.TEXT_BINH_THUONG, idGroup: idGroup, idDeadline: idDeadline, idJob: -1, date: Enum.getCurrentDateDDMMYYYY())
                        DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(idReceiver)").child("\(idSender)").child("\(noti.id)").setValue(noti.toDictionary())
                    }
                  
                    DB_REALTIME.child(Enum.DEADLINE_JOIN_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(idSender)").removeValue()
                    DB_REALTIME.child(Enum.DEADLINE_TABLE).child("\(idGroup)").child("\(idDeadline)")
                        .observe(DataEventType.value){
                            snapshot1 in
                            if kiemTra {
                            if snapshot1.childrenCount>0{
                                if let value = snapshot1.value as? NSDictionary{
                                    let join = value["join"] as? Int ?? -1
                                    DB_REALTIME.child(Enum.DEADLINE_TABLE).child("\(idGroup)").child("\(idDeadline)").child("join").setValue(join-1)
                                    kiemTra = false
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
    static func roiJob(idReceiver:Int,idSender:Int,content:String,idGroup:Int,idDeadline:Int,idJob:Int,closure: @escaping ()->Void){
        var kiemTra = true
        var idNew = 0
        //Duyệt để lấy id thông báo mới nhất
        DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(idReceiver)").child("\(idSender)").observe(DataEventType.value){
            snapshot in
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0){
                if kiemTra {
                    if idSender != idReceiver{
                        idNew = Int(snapshot.childrenCount)
                        let noti = Notification(id: idNew, idSender: idSender, idReceiver: idReceiver, content: content, type: Enum.TEXT_BINH_THUONG, idGroup: idGroup, idDeadline: idDeadline, idJob: idJob, date: Enum.getCurrentDateDDMMYYYY())
                        DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(idReceiver)").child("\(idSender)").child("\(noti.id)").setValue(noti.toDictionary())
                    }
                  
                    DB_REALTIME.child(Enum.JOB_MEMBER_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(idJob)").child("\(idSender)").removeValue()
                    DB_REALTIME.child(Enum.JOB_NOT_COMPLETE).child("\(idSender)").child("\(idGroup)").child("\(idDeadline)").child("\(idJob)").removeValue()
                    DB_REALTIME.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(idJob)")
                        .observe(DataEventType.value){
                            snapshot1 in
                            if kiemTra {
                            if snapshot1.childrenCount>0{
                                if let value = snapshot1.value as? NSDictionary{
                                    let join = value["join"] as? Int ?? -1
                                    DB_REALTIME.child(Enum.JOB_TABLE).child("\(idGroup)").child("\(idDeadline)").child("\(idJob)").child("join").setValue(join-1)
                                    closure()
                                    kiemTra = false
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
    
    static func xacNhanVaoGroup(notification:Notification,join:Int){
        var kiemTra = true
        if kiemTra == true{
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                if kiemTra == true{
                    let dictionary = ["id":notification.idReceiver,"fit":0]
                    DB_REALTIME.child(Enum.MEMBER_TABLE).child("\(notification.idGroup)").child("\(notification.idReceiver)").setValue(dictionary)
                    DB_REALTIME.child(Enum.GROUP_JOIN_TABLE).child("\(notification.idReceiver)").child("\(notification.idGroup)").child("id").setValue(notification.idGroup)
                    DB_REALTIME.child(Enum.GROUP_TABLE).child("\(notification.idGroup)").child("join").setValue(join+1)
                    DB_REALTIME.child(Enum.NOTIFICATION_TABLE).child("\(notification.idReceiver)").child("\(notification.idSender)").child("\(notification.id)").removeValue()
                    kiemTra = false
                }
                
                
            }
        }
        
    }
    
}
