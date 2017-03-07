//
//  PhotoListResponseModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/7.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class PhotoListResponseModel: NSObject {
    public var hasMore: Bool
    public var photoList: [ScenicSpotModel]
    
    init(hasMore: Bool, photoList: [ScenicSpotModel]) {
        self.hasMore = hasMore
        self.photoList = photoList
        super.init()
    }
}
