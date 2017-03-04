//
//  ScenicSpotModel.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/4.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class ScenicSpot: NSObject, NSCoding {
    public var sharedPeopleID: String
    public var chineseName: String
    public var englishName: String
    public var bestTime: String
    public var image: UIImage
    public var location: String
    public var recommendReason: String
    
    init(sharedPeopleID: String, chineseName: String, englishName: String, bestTime: String, image: UIImage, location: String, recommendReason: String) {
        self.sharedPeopleID = sharedPeopleID
        self.chineseName = chineseName
        self.englishName = englishName
        self.bestTime = bestTime
        self.image = image
        self.location = location
        self.recommendReason = recommendReason
        super.init()
    }
    
    //MARK: - nscoding
    required init?(coder aDecoder: NSCoder) {
        self.sharedPeopleID = aDecoder.decodeObject(forKey: "sharedPeopleID") as? String ?? ""
        self.chineseName = aDecoder.decodeObject(forKey: "chineseName") as? String ?? ""
        self.englishName = aDecoder.decodeObject(forKey: "englishName") as? String ?? ""
        self.bestTime = aDecoder.decodeObject(forKey: "bestTime") as? String ?? ""
        self.image = aDecoder.decodeObject(forKey: "image") as? UIImage ?? UIImage()
        self.location = aDecoder.decodeObject(forKey: "location") as? String ?? ""
        self.recommendReason = aDecoder.decodeObject(forKey: "recommendReason") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sharedPeopleID, forKey: "sharedPeopleID")
        aCoder.encode(chineseName, forKey: "chineseName")
        aCoder.encode(englishName, forKey: "englishName")
        aCoder.encode(bestTime, forKey: "bestTime")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(location, forKey: "location")
        aCoder.encode(recommendReason, forKey: "recommendReason")
    }
}
