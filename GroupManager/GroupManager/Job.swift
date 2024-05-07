//
//  Job.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/25/24.
//

import Foundation
class Job{
    var id:Int
    var idDeadline:Int
    var title:String
    var image:String
    var quantity:Int
    var description:String
    var deadline:String
    var point:Int
    var titleDeadline:String
    var titleGroup:String
    var status: Bool
    var join:Int
    init(id:Int,idDeadline:Int,title:String,image:String,quantity:Int,description:String,deadline:String,point:Int,titleDeadline:String,titleGroup:String,status:Bool,join:Int) {
        self.id = id
        self.idDeadline = idDeadline
        self.title = title
        self.image = image
        self.quantity = quantity
        self.description = description
        self.deadline = deadline
        self.point = point
        self.titleDeadline = titleDeadline
        self.titleGroup = titleGroup
        self.status = status
        self.join = join
    }
}
