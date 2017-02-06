//
//  SettingViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/6.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }

    //MARK: - private
    private func initInternal() {
        navigationItem.title = Constants.SET
        view.backgroundColor = .white
        var rect = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 40)
        let modifyNameSection = SettingSectionView(frame: rect, type: .LabelType)
        modifyNameSection.title.text = Constants.MODITY_NAME
        modifyNameSection.nameLabel.text = "test1992"
        rect = rect.offsetBy(dx: 0, dy: 40)
        let feedBackSection = SettingSectionView(frame: rect, type: .LabelType)
        feedBackSection.title.text = Constants.FEEDBACK
        rect = rect.offsetBy(dx: 0, dy: 40)
        let saveOriginalSection = SettingSectionView(frame: rect, type: .SwitchType)
        saveOriginalSection.title.text = Constants.SAVE_ORIGINAL
        rect = rect.offsetBy(dx: 0, dy: 40)
        let clearCacheSection = SettingSectionView(frame: rect, type: .LabelType)
        clearCacheSection.title.text = Constants.CLEAR_CACHE
        
        view.addSubview(feedBackSection)
        view.addSubview(modifyNameSection)
        view.addSubview(saveOriginalSection)
        view.addSubview(clearCacheSection)
    }
    
    override func isTabbarVisible() -> Bool {
        return false;
    }

}
