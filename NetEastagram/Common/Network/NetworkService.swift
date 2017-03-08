//
//  NetworkService.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/7.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import HandyJSON
import AFNetworking

class NetworkService: NSObject {
    static private let instance: NetworkService = NetworkService()
    
    static func sharedService() -> NetworkService {
        return instance
    }
    
    public func requestPhotoList(with photoListRequestModel: PhotoListRequestModel,
                                 success: ((PhotoListDataModel?) -> Void)?,
                                 failure: ((Error) -> Void)?) {
        let configuration = URLSessionConfiguration.default
        let manager = AFURLSessionManager(sessionConfiguration: configuration)
        let parameters = ["limit": photoListRequestModel.limit, "offset": photoListRequestModel.offset]
        let request = AFHTTPRequestSerializer().request(withMethod: "GET", urlString: Constants.PHOTO_LIST, parameters: parameters, error: nil)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        let jsonResponseSerializer = AFJSONResponseSerializer()
        jsonResponseSerializer.acceptableContentTypes?.insert("text/plain")
        manager.responseSerializer = jsonResponseSerializer
        let dataTask = manager.dataTask(with: request as URLRequest) { (response, responseObject, error) in
            if let error = error, let failure = failure {
                failure(error)
                return
            }
            if  let object = BaseResponseModel<PhotoListDataModel>.deserialize(from: responseObject as? NSDictionary), let success = success {
                if object.code == 200 {
                    success(object.data)
                }
            }
            
        }
        dataTask.resume()
    }
}
