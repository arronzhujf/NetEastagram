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
        db.executeUpdate("CREATE TABLE IF NOT EXISTS user_photo(userid text, photo text)", withArgumentsIn: nil)
    }
    
    static private func createDBPath() -> String {
        let documentsFolder = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(DBManager.fileName)
        return documentsFolder.path
    }
    
     func executeUpdate(with sql: String, values: [Any]!) -> Bool {
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
    
    func executeQuery(with sql: String, values: [Any]!) -> Array<[AnyHashable: Any]>? {
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
    
    func addMark(photoInfo model: PhotoDataModel, for userID: String) -> Bool {
        guard let modelJSONString = model.toJSONString() else {
            return false
        }
        let query_sql = "SELECT * FROM user_photo WHERE userid=" + userID + "AND photo=" + modelJSONString
        if let resArray = executeQuery(with: query_sql, values: nil), resArray.count > 0 {
            return true
        } else {
            let insert_sql = "INSERT INTO user_photo (userid, photo) values (?, ?)"
            return executeUpdate(with: insert_sql, values: [userID, modelJSONString])
        }
    }
    
    func cancelMark(photoInfo model: PhotoDataModel, for userID: String) -> Bool {
        guard let modelJSONString = model.toJSONString() else {
            return false
        }
        let delete_sql = "DELETE * FROM user_photo WHERE userid=" + userID + "AND photo=" + modelJSONString
        return executeUpdate(with: delete_sql, values: nil)
    }
}
