//
//  PhotoListRequestModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/7.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class PhotoListRequestModel: BaseRequestModel {
    public var limit: Int = 0
    public var offset: Int = 0
    
    required init() {}
    
    convenience init(limit: Int, offset: Int) {
        self.init()
        self.limit = limit
        self.offset = offset
    }
}
