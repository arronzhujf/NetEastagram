//
//  UserMarkViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/9.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class UserMarkViewController: PhotoTableBaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userID = SharedPreferences.shared().userID {
            dataSource = DBManager.sharedManager().allMarks(of: userID)
            tableView.reloadData()
        }
    }
    
    override func isTabbarVisible() -> Bool {
        return false;
    }
    
    //MARK: - private
    override func initInternal() {
        super.initInternal()
        navigationItem.title = Constants.MARK
    }
    
}
