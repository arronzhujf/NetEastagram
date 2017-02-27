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
    private lazy var setButton: UIBarButtonItem = self.createSetButton()
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initInternal()
        isLogin = UserDefaults.standard.bool(forKey: Constants.IS_LOGIN_KEY)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navigationController = navigationController else { return }
        super.viewWillAppear(animated)
        navigationController.navigationBar.barTintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0), NSForegroundColorAttributeName: UIColor(netHex: 0x666666)]
        setStatusBarBackgroundColor(color: .white)
        isLogin = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.barTintColor = UIColor(netHex: 0x607d8b)
        navigationController.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 18.0), NSForegroundColorAttributeName: UIColor.white]
        setStatusBarBackgroundColor(color: UIColor(netHex: 0x3b515c))
    }
    
    //MARK: - private
    private func initInternal() {
        navigationItem.title = Constants.USER_TITLE
        navigationItem.rightBarButtonItem = setButton
        (setButton.customView as! UIButton).isEnabled = false
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
            (setButton.customView as! UIButton).isEnabled = true
        } else {
            let notLoginHeaderView = UserNotLoginHeaderView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 185.0))
            userTableView.tableHeaderView = notLoginHeaderView
            (setButton.customView as! UIButton).isEnabled = false
        }
    }
    
    @objc func tapOnSetButton() {
        guard let navigationController = navigationController  else {
            return
        }
        navigationController.pushViewController(SettingViewController(), animated: true)
    }
    
    //MARK: - lazy init
    private func createUserTableView() -> UITableView {
        let res = UITableView()
        res.delegate = self
        res.dataSource = self
        return res
    }
    
    private func createSetButton() -> UIBarButtonItem {
        let customBtn = UIButton(type: .custom)
        customBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        customBtn.setBackgroundImage(#imageLiteral(resourceName: "me-set"), for: .normal)
        customBtn.setBackgroundImage(#imageLiteral(resourceName: "me-set-light"), for: .disabled)
        customBtn.addTarget(self, action: #selector(tapOnSetButton), for: .touchUpInside)
        let res = UIBarButtonItem(customView: customBtn)
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
            cell.content.text = Constants.MY_MARK
        case 2:
            cell.icon.image = #imageLiteral(resourceName: "me-favorite")
            cell.content.text = Constants.MY_FAVORITE
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
