//
//  Notification.swift
//  GroupManager
//
//  Created by Gia Nghiem on 5/1/24.
//

import Foundation
class Notification  {
    var id:Int
    var idSender:Int
    var idReceiver:Int
    var content:String
    var type:Int
    var idGroup:Int
    var idDeadline:Int
    var idJob:Int
    var date:String
    init(id:Int,idSender:Int,idReceiver:Int,content:String,type:Int,idGroup:Int,idDeadline:Int,idJob:Int,date:String) {
        self.id = id
        self.idSender = idSender
        self.idReceiver = idReceiver
        self.content = content
        self.type = type
        self.idGroup = idGroup
        self.idDeadline = idDeadline
        self.idJob = idJob
        self.date = date
    }
}
