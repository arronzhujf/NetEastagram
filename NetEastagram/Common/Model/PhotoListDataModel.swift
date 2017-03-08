//
//  PhotoListDataModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/8.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import HandyJSON

class PhotoListDataModel: HandyJSON {
    public var hasMore: Bool = false
    public var photolist: [PhotoDataModel] = []
    
    required init() {}
}
