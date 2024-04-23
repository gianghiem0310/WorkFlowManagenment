//
//  Job.swift
//  GroupManager
//
//  Created by Gia Nghiem on 4/21/24.
//

import Foundation
class CongViec{
    var title:String = ""
    init(title:String) {
        self.title = title
    }
    func getTitle()->String{
        return title
    }
    func setTitle(title:String){
        self.title = title
    }
}
