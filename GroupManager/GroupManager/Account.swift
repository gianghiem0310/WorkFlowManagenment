//
//  Account.swift
//  GroupManager
//
//  Created by sakurashi on 2/18/1403 AP.
//

import Foundation
class Account {
    var id:Int
    var username:String
    var password:String
    init(id:Int,username:String,password:String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
