//
//  DBManager.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/8.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import HandyJSON
import FMDB

class DBManager: NSObject {
    static private let instance: DBManager = DBManager()
    static private let fileName = "neteastagram.db"
    private let db: FMDatabase
    
    static func sharedManager() -> DBManager {
        return instance
    }
    
    override init() {
        db = FMDatabase(path: DBManager.createDBPath())
        super.init()
        db.open()
        db.executeUpdate("CREATE TABLE IF NOT EXISTS user_photo(userid integer, photo text)", withArgumentsIn: nil)
        db.close()
    }
    
    static private func createDBPath() -> String {
        let documentsFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(DBManager.fileName)
        return documentsFolder.path
    }
    
    fileprivate func executeUpdate(with sql: String, values: [Any]!) -> Bool {
        guard db.open() else { return false }
        var isUpdate = true
        do {
            try db.executeUpdate(sql, values: values)
        } catch {
            isUpdate = false
        }
        db.close()
        return isUpdate
    }
    
    fileprivate func executeQuery(with sql: String, values: [Any]!) -> Array<[AnyHashable: Any]>? {
        var res = Array<[AnyHashable: Any]>()
        if !db.open() { return res }
        let resSet = try? db.executeQuery(sql, values: values)
        if let resSet = resSet {
            while resSet.next() {
                let dic = resSet.resultDictionary()
                res.append(dic!)
            }
        }
        resSet?.close()
        db.close()
        return res
    }
}


    //MARK: - user mark operation
extension DBManager {
    func isMarked(photoInfo model: PhotoDataModel, for userID: Int) -> Bool {
        guard let modelJSONString = model.toJSONString() else {
            return false
        }
        var res = false
        let query_sql = "SELECT * FROM user_photo WHERE userid=" + String(userID) + " AND photo='" + modelJSONString + "'"
        if let resArray = executeQuery(with: query_sql, values: nil), resArray.count > 0 {
            res = true
        }
        return res

    }
    
    func addMark(photoInfo model: PhotoDataModel, for userID: Int) -> Bool {
        guard let modelJSONString = model.toJSONString() else {
            return false
        }
        if isMarked(photoInfo: model, for: userID) {
            return true
        }
        let insert_sql = "INSERT INTO user_photo (userid, photo) values (?, ?)"
        return executeUpdate(with: insert_sql, values: [userID, modelJSONString])
        
    }
    
    func cancelMark(photoInfo model: PhotoDataModel, for userID: Int) -> Bool {
        guard let modelJSONString = model.toJSONString() else {
            return false
        }
        let delete_sql = "DELETE FROM user_photo WHERE userid=" + String(userID) + " AND photo='" + modelJSONString + "'"
        return executeUpdate(with: delete_sql, values: nil)
    }
    
    func allMarks(of userID: Int) -> [PhotoDataModel] {
        var res = [PhotoDataModel]()
        let query_sql = "SELECT photo FROM user_photo WHERE userid=" + String(userID)
        if let resArray = executeQuery(with: query_sql, values: nil) {
            for item in resArray {
                if let photoInfo = PhotoDataModel.deserialize(from: (item.first?.value as? String)) {
                    res.append(photoInfo)
                }
            }
        }
        return  res
    }
}
