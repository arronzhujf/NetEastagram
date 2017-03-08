//
//  SharedPreferences.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/9.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class SharedPreferences: NSObject {
    static private let instance: SharedPreferences = SharedPreferences()
    var name: String?
    var userID: Int?
    
    static func shared() -> SharedPreferences {
        return instance
    }
}
