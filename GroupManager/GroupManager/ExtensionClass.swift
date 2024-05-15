//
//  ExtensionClass.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/22/24.
//

import Foundation
extension Group{
    func toDictionary()->[String:Any]{
        return ["id":id,"title":title,"image":image,"quantity":quantity,"captain":captain,"status":status,"join":join]
    }
}
extension Job{
    func toDictionary()->[String:Any]{
        return ["id":id, "idDeadline":idDeadline,"title":title,"image":image,"quantity":quantity,"description": description,"deadline":deadline,"point":point,"status":status,"titleGroup":titleGroup,"titleDeadline":titleDeadline,"join":join]
    }
}
extension Deadline{
    func toDictionary() -> [String:Any] {
        return ["id":id,"idGroup":idGroup,"deadline":deadline,"quantity":quantity,"status":status,"join":join]
    }
}
extension Notification{
    func toDictionary() -> [String:Any] {
        return ["id":id,"idSender":idSender,"idReceiver":idReceiver,"content":content,"type":type,"idGroup":idGroup,"idDeadline":idDeadline,"idJob":idJob,"date":date]
    }
}



