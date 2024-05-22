//
//  Nhom.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/23/24.
//

import Foundation
class Group {
    var id: Int
    var title: String
    var image: String
    var quantity: Int
    var captain: Int
    var status: Bool
    var join:Int
    init(id:Int, title:String,image:String,quantity:Int,captain:Int,status:Bool,join:Int) {
        self.id = id
        self.title = title
        self.image = image
        self.quantity = quantity
        self.captain = captain
        self.status = status
        self.join = join
    }
    
}

