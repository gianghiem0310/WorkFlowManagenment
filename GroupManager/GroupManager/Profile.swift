//
//  Profile.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/30/24.
//

import Foundation
class Profile {
    var idAccount:Int
    var avatar:String
    var name:String
    var phone:String
    var email:String
    var fit:Int
    init(idAccount:Int,avatar:String,name:String,phone:String,email:String,fit:Int) {
        self.idAccount = idAccount
        self.avatar = avatar
        self.name = name
        self.phone = phone
        self.email = email
        self.fit = fit
    }
}
