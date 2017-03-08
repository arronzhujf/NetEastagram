//
//  UserModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/9.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import HandyJSON

class UserModel: HandyJSON {
    var name: String = ""
    var userID: Int = 0
    required init() {}
    
    convenience init(name: String, userID: Int) {
        self.init()
        self.name = name
        self.userID = userID
    }
}
