//
//  UserViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/1.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

class UserViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    var isLogin: Bool = false {
        didSet {
            if isLogin != oldValue {
                 updateUI(by: isLogin)
            }
        }
    }
    private lazy var userTableView: UITableView = self.createUserTableView()
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initInternal()
        isLogin = UserDefaults.standard.bool(forKey: Constants.IS_LOGIN_KEY)
    }

    //MARK: - private
    private func initInternal() {
        navigationItem.title = Constants.USER_TITLE
        let notLoginHeaderView = UserNotLoginHeaderView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 185.0))
        userTableView.tableHeaderView = notLoginHeaderView
        userTableView.isScrollEnabled = false
        view.addSubview(userTableView)

        userTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateUI(by isLogin: Bool) {
        if isLogin {
            let loginedHeaderView = UserLoginedHeaderView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 185.0))
            userTableView.tableHeaderView = loginedHeaderView
        } else {
            let notLoginHeaderView = UserNotLoginHeaderView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 185.0))
            userTableView.tableHeaderView = notLoginHeaderView
        }
    }
    
    //MARK: - lazy init
    private func createUserTableView() -> UITableView {
        let res = UITableView()
        res.delegate = self
        res.dataSource = self
        return res
    }
    
    //MARK: - delegate & dataSource
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = UIView.fromNib()
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            cell.icon.image = #imageLiteral(resourceName: "me-post")
            cell.content.text = Constants.POST
        case 1:
            cell.icon.image = #imageLiteral(resourceName: "me-mark")
            cell.content.text = Constants.MARK
        case 2:
            cell.icon.image = #imageLiteral(resourceName: "me-favorite")
            cell.content.text = Constants.FAVORITE
        case 3:
            cell.icon.image = #imageLiteral(resourceName: "me-invite")
            cell.content.text = Constants.INVITE
        default: break
        
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 39.0
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击cell: - TODO")
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}
