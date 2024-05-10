//
//  Account.swift
//  GroupManager
//
//  Created by Nguyen Hong Phuc on 5/9/24.
//

import Foundation
class Account {
    var id:Int
    var username:String
    var password:String
    
    init(id:Int, username:String, password:String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
