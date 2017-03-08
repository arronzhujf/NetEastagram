//
//  PhotoDataModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/8.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import HandyJSON

class PhotoDataModel: HandyJSON {
    public var photoNo: String = ""
    public var imageUrl: String = ""
    public var title: String = ""
    public var location: String = ""
    public var posterName: String = ""
    public var province: String = ""
    public var favorite: Bool = false
    public var reason: String = ""
    
    required init() {
    }
    
    convenience init(photoNo: String, imageUrl: String, title: String, location: String, posterName: String, province: String, favorite: Bool, reason: String) {
        self.init()
        self.photoNo = photoNo
        self.imageUrl = imageUrl
        self.title = title
        self.location = location
        self.posterName = posterName
        self.province = province
        self.favorite = favorite
        self.reason = reason
    }
    
//    public func configModel(photoNo: String, imageUrl: String, title: String, location: String, posterName: String, province: String, favorite: Bool, reason: String) -> ScenicSpotModel{
//        let model = ScenicSpotModel()
//        model.photoNo = photoNo
//        model.imageUrl = imageUrl
//        model.title = title
//        model.location = location
//        model.posterName = posterName
//        model.province = province
//        model.favorite = favorite
//        model.reason = reason
//        return model
//    }

}
