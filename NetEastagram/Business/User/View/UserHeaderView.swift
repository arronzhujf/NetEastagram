//
//  UserNotLoginHeaderView.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/5.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

class UserNotLoginHeaderView: UIView {
    private lazy var loginButton: UIButton = self.createLoginButton()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initInternal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func initInternal() {
        backgroundColor = UIColor(netHex: 0x607D8B)
        addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(122.5)
        }
    }
    
    //MARK: - lazy init
    
    private func createLoginButton() -> UIButton {
        let res = UIButton()
        res.backgroundColor = .white
        res.layer.cornerRadius = 5
        res.setBackgroundImage(#imageLiteral(resourceName: "me-login"), for: .normal)
        res.setBackgroundImage(#imageLiteral(resourceName: "me-login-press"), for: .highlighted)
        return res
    }
}

// MARK: -

class UserLoginedHeaderView: UIView {
    private lazy var topView: UIView = self.createTopView()
    private lazy var bottomView: UIView = self.createBottomView()
    public lazy var portrait: UIImageView = self.createPortrait()
    public lazy var nameLabel: UILabel = self.createNameLabel()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initInternal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func initInternal() {
        addSubview(topView)
        addSubview(bottomView)
        addSubview(portrait)
        addSubview(nameLabel)
    
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(180.0)
        }
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        portrait.snp.makeConstraints { (make) in
            make.center.equalToSuperview().offset(-5.0)
            make.width.equalTo(portrait.snp.height)
            make.left.equalTo(self.snp.left).offset(153.5)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(portrait.snp.bottom).offset(10)
        }
    }
    
    //MARK: - lazy init
    
    private func createTopView() -> UIView {
        let res = UIView()
        res.backgroundColor = UIColor(netHex: 0x607D8B)
        return res
    }
    
    private func createBottomView() -> UIView {
        let res = UIView()
        res.backgroundColor = .white
        return res
    }
    
    private func createPortrait() -> UIImageView {
        let res = UIImageView(image: #imageLiteral(resourceName: "me"))
        return res
    }
    
    private func createNameLabel() -> UILabel {
        let res = UILabel()
        res.text = "test1992"
        res.textColor = UIColor(netHex: 0xacacac)
        res.font = UIFont.systemFont(ofSize: 13)
        return res
    }
}
