//
//  BaseResponseModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/7.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import Foundation
import HandyJSON

class BaseResponseModel<T: HandyJSON>: HandyJSON {
    var message: String?
    var code: Int?
    var data: T?
    
    required init() {}
}
