//
//  DetailViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/4.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class DetailViewController: BaseViewController {
    public var model: PhotoDataModel?
    private lazy var scrollView: UIScrollView = self.createScrollView()
    private lazy var bottomBar: UIView = self.createBottomBar()
    private lazy var topBar: UIView = self.createTopBar()
    private let reasonLabel: UILabel
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        reasonLabel = UILabel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize.height = max(reasonLabel.frame.maxY, scrollView.height+1)
    }
    
    override func isTabbarVisible() -> Bool {
        return false
    }
    
    //MARK: - private
    private func initInternal() {
        navigationItem.title = Constants.DETAILS
        guard let model = model else { return }
        
        let sceneryImageView = UIImageView(frame: CGRect(x: 0, y: topBar.height, width: Constants.SCREEN_WIDTH, height: 313/375.0*Constants.SCREEN_WIDTH))
        sceneryImageView.sd_setImage(with: URL(string: model.imageUrl))
        
        let locationLabel = UILabel()
        locationLabel.text = model.province + "  " + model.location
        locationLabel.textColor = Constants.TEXT_GRAY_COLOR
        locationLabel.textAlignment = .right
        locationLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        let locationBottomLine = UIView()
        locationBottomLine.backgroundColor = Constants.LIGHT_GRAY_COLOR
        
        let reasonLeftImage = UIImageView(image: UIImage(named: "home-detail-torightline"))
        let reasonRightImage = UIImageView(image: UIImage(named: "home-detail-toleftline"))
        let reasonImage = UIImageView(image: UIImage(named: "home-detail-reason"))
        
        reasonLabel.text = model.reason
        reasonLabel.textColor = Constants.TEXT_GRAY_COLOR
        reasonLabel.font = UIFont.systemFont(ofSize: 12)
        reasonLabel.lineBreakMode = .byWordWrapping
        reasonLabel.numberOfLines = 0
        
        view.addSubview(scrollView)
        scrollView.addSubview(topBar)
        view.addSubview(bottomBar)
        scrollView.addSubview(sceneryImageView)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(locationBottomLine)
        scrollView.addSubview(reasonLeftImage)
        scrollView.addSubview(reasonRightImage)
        scrollView.addSubview(reasonImage)
        scrollView.addSubview(reasonLabel)
        
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(sceneryImageView.snp.bottom).offset(14)
            make.right.equalTo(sceneryImageView).offset(-10)
            make.left.equalToSuperview()
        }
        
        locationBottomLine.snp.makeConstraints { (make) in
            make.left.right.equalTo(sceneryImageView)
            make.height.equalTo(1)
            make.top.equalTo(locationLabel.snp.bottom).offset(14)
        }
        
        reasonImage.snp.makeConstraints { (make) in
            make.top.equalTo(locationBottomLine.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        reasonLeftImage.snp.makeConstraints { (make) in
            make.left.equalTo(sceneryImageView).offset(20)
            make.right.equalTo(reasonImage.snp.left).offset(-10)
            make.centerY.equalTo(reasonImage)
        }
        
        reasonRightImage.snp.makeConstraints { (make) in
            make.left.equalTo(reasonImage.snp.right).offset(10)
            make.right.equalTo(sceneryImageView).offset(-20)
            make.centerY.equalTo(reasonImage)
        }
        
        reasonLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(sceneryImageView)
            make.width.equalTo(Constants.SCREEN_WIDTH-62)
            make.top.equalTo(reasonImage.snp.bottom).offset(16)
        }
    }
    
    //MARK: - action
    @objc func markBtnClick() {
        
    }
    
    @objc func downloadBtnClick() {
    }
    
    @objc func shareBtnClick() {
    }
    
    //MARK: - lazy init
    private func createScrollView() -> UIScrollView {
        let res = UIScrollView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT-naviBarHeight-tabBarHeight-statusBarHeight))
        res.backgroundColor = .white
        res.contentSize = CGSize(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT*2)
        res.showsHorizontalScrollIndicator = false
        res.showsVerticalScrollIndicator = false
        return res
    }
    
    private func createTopBar() -> UIView {
        let res = UIView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 63))
        res.backgroundColor = .white
        let portrait = UIImageView(image: UIImage(named: "home-detail-people"))
        res.addSubview(portrait)
        let userNameLabel = UILabel()
        userNameLabel.text = model?.posterName
        userNameLabel.textColor = Constants.LIGHT_GRAY_COLOR
        userNameLabel.font = UIFont.systemFont(ofSize: 13)
        res.addSubview(userNameLabel)
        
        portrait.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(14)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(portrait.snp.right).offset(9)
        }
        return res
    }
    
    private func createBottomBar() -> UIView {
        let res = UIView(frame: CGRect(x: 0, y: scrollView.height, width: Constants.SCREEN_WIDTH, height: tabBarHeight))
        let topLine = UIView(frame: CGRect(x: 0, y: 0, width: res.width, height: 1))
        topLine.backgroundColor = Constants.LIGHT_GRAY_COLOR
        res.addSubview(topLine)
        
        let markBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 22))
        markBtn.setImage(UIImage(named: "home-detail-emptystar"), for: .normal)
        markBtn.setTitle(Constants.MARK, for: .normal)
        markBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, -8)
        markBtn.setTitleColor(Constants.TEXT_GRAY_COLOR, for: .normal)
        markBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        markBtn.addTarget(self, action: #selector(markBtnClick), for: .touchUpInside)
        res.addSubview(markBtn)
        
        let downloadBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 34, height: 22))
        downloadBtn.setImage(UIImage(named: "home-detail-download"), for: .normal)
        downloadBtn.setTitle(Constants.DOWNLOAD, for: .normal)
        downloadBtn.titleEdgeInsets = markBtn.titleEdgeInsets
        downloadBtn.setTitleColor(Constants.TEXT_GRAY_COLOR, for: .normal)
        downloadBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        downloadBtn.addTarget(self, action: #selector(downloadBtnClick), for: .touchUpInside)
        res.addSubview(downloadBtn)
        
        let shareBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        shareBtn.setImage(UIImage(named: "home-detail-more"), for: .normal)
        shareBtn.addTarget(self, action: #selector(shareBtnClick), for: .touchUpInside)
        res.addSubview(shareBtn)
        
        markBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(22)
            make.centerY.equalToSuperview()
        }
        
        downloadBtn.snp.makeConstraints { (make) in
            make.left.equalTo(markBtn.snp.right).offset(45)
            make.centerY.equalToSuperview()
        }
        
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-22)
            make.centerY.equalToSuperview()
        }
        
        return res
        
    }
    
}
