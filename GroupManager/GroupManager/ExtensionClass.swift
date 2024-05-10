//
//  ExtensionClass.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/22/24.
//

import Foundation
extension Group{
    func toDictionary()->[String:Any]{
        return ["id":id,"title":title,"image":image,"quantity":quantity,"captain":captain,"status":status]
    }
}
extension Job{
    func toDictionary()->[String:Any]{
        return ["id":id, "idDeadline":idDeadline,"title":title,"image":image,"quantity":quantity,"description": description,"deadline":deadline,"point":point,"status":status,"titleGroup":titleGroup,"titleDeadline":titleDeadline]
    }
}

extension Account{
    func toDictionary() -> [String:Any] {
        return ["id":id, "username":username, "password":password]
    }
}

extension Profile{
    func toDictionary() -> [String:Any] {
        return ["idAccount":idAccount, "avatar":avatar, "name":name, "phone":phone, "email":email, "fit":fit]
    }
}
