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
