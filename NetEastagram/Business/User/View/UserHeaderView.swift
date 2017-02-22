//
//  UserNotLoginHeaderView.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/5.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

protocol UserNotLoginHeaderViewDelegate: NSObjectProtocol {
    func headerView(_ notLoginHeaderView: UserNotLoginHeaderView, didTapLoginButton button: UIButton)
}

class UserNotLoginHeaderView: UIView {
    private lazy var loginButton: UIButton = self.createLoginButton()
    weak var delegate: UserNotLoginHeaderViewDelegate?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initInternal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    //MARK: - private
    private func initInternal() {
        backgroundColor = UIColor(netHex: 0x607D8B)
        addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.top.equalToSuperview().offset(70)
            make.left.equalToSuperview().offset(122.5)
        }
    }
    
    @objc private func tapOnLoginButton() {
        if let delegate = delegate {
            delegate.headerView(self, didTapLoginButton: loginButton)
        }
    }
    
    //MARK: - lazy init
    
    private func createLoginButton() -> UIButton {
        let res = UIButton()
        res.backgroundColor = .white
        res.layer.cornerRadius = 5
        res.setBackgroundImage(#imageLiteral(resourceName: "me-login"), for: .normal)
        res.setBackgroundImage(#imageLiteral(resourceName: "me-login-press"), for: .highlighted)
        res.addTarget(self, action: #selector(tapOnLoginButton), for: .touchUpInside)
        return res
    }
}

// MARK: -

class UserLoginedHeaderView: UIView {
    private lazy var topView: UIView = self.createTopView()
    private lazy var bottomView: UIView = self.createBottomView()
    public lazy var portrait: UIImageView = self.createPortrait()
    public lazy var nameLabel: UILabel = self.createNameLabel()
    
    override init(frame: CGRect) {
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
            make.height.equalTo(90.0)
        }
        bottomView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
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
        let res = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH-307, height: Constants.SCREEN_WIDTH-307))
        res.center = CGPoint(x: Constants.SCREEN_WIDTH / 2.0, y: 90)
        res.image = #imageLiteral(resourceName: "me")
        res.layer.cornerRadius = res.frame.width / 2.0
        res.clipsToBounds = true
        return res
    }
    
    private func createNameLabel() -> UILabel {
        let res = UILabel()
        res.text = "test1992"
        res.textColor = Constants.GRAY_COLOR
        res.font = UIFont.systemFont(ofSize: 13)
        return res
    }
}
