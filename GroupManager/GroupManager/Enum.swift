//
//  Enum.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/22/24.
//

import Foundation
import FirebaseDatabase
import UIKit
class Enum{
    static let ISLOGIN = "isLogin"
    
    
    static let STORYBOARD = UIStoryboard(name: "Main", bundle: nil)
    
    static let DB_REALTIME = Database.database().reference()
    // MARK: Kí tự database
    static let NHOM_TABLE = "Nhoms"
}
