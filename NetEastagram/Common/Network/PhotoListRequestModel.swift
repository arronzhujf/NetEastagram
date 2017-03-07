//
//  PhotoListRequestModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/7.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class PhotoListRequestModel: NSObject {
    public var limit: Int
    public var offset: Int
    
    init(limit: Int, offset: Int) {
        self.limit = limit
        self.offset = offset
        super.init()
    }
}
