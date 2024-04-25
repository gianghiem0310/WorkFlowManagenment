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
}
