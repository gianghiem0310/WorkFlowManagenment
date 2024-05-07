//
//  Deadline.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/28/24.
//

import Foundation
class Deadline{
    var id:Int
    var idGroup:Int
    var deadline:String
    var quantity:Int
    var status:Bool
    var join:Int
    init(id:Int,idGroup:Int,deadline:String,quantity:Int,status:Bool,join:Int) {
        self.id = id
        self.idGroup = idGroup
        self.deadline = deadline
        self.quantity = quantity
        self.status = status
        self.join = join
    }
}
