//
//  SettingViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/6.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController, SettingSectionViewDelegate {
    private var saveOriginalSection: SettingSectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    override func isTabbarVisible() -> Bool {
        return false;
    }

    //MARK: - private
    private func initInternal() {
        navigationItem.title = Constants.SET
        var rect = CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: 40)
        let modifyNameSection = SettingSectionView(frame: rect, type: .LabelType)
        modifyNameSection.title.text = Constants.MODITY_NAME
        modifyNameSection.nameLabel.text = "test1992"
        modifyNameSection.delegate = self
        
        rect = rect.offsetBy(dx: 0, dy: 40)
        let feedBackSection = SettingSectionView(frame: rect, type: .LabelType)
        feedBackSection.title.text = Constants.ADVISE_FEEDBACK
        feedBackSection.delegate = self
        
        rect = rect.offsetBy(dx: 0, dy: 40)
        saveOriginalSection = SettingSectionView(frame: rect, type: .SwitchType)
        saveOriginalSection?.title.text = Constants.SAVE_ORIGINAL
        saveOriginalSection?.delegate = self
        updateSaveOriginalSectionUI()
        
        rect = rect.offsetBy(dx: 0, dy: 40)
        let clearCacheSection = SettingSectionView(frame: rect, type: .LabelType)
        clearCacheSection.title.text = Constants.CLEAR_CACHE
        clearCacheSection.delegate = self
        
        let logoutBtn = UIButton(frame: CGRect(x: 80, y: rect.maxY+58, width: Constants.SCREEN_WIDTH-160, height: 35))
        logoutBtn.setBackgroundImage(#imageLiteral(resourceName: "me-logout"), for: .normal)
        logoutBtn.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
        
        view.addSubview(feedBackSection)
        view.addSubview(modifyNameSection)
        view.addSubview(clearCacheSection)
        view.addSubview(logoutBtn)
        if let saveOriginalSection = saveOriginalSection {
            view.addSubview(saveOriginalSection)
        }
    }
    
    @objc func logoutBtnTapped() {
        showLogoutActionSheet()
    }
    
    private func updateSaveOriginalSectionUI() {
        if UserDefaults.standard.bool(forKey: Constants.IS_SAVE_ORIGINAL_KEY) {
            saveOriginalSection?.switchImageView.image = UIImage(named: "me-switch-open")
        } else {
            saveOriginalSection?.switchImageView.image = UIImage(named: "me-switch")
        }
    }
    
    //MARK: - action
    private func showClearActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: Constants.CONFIRM_CLEAR, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showLogoutActionSheet() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: Constants.CANCEL, style: .cancel, handler: nil)
        let logoutAction = UIAlertAction(title: Constants.CONFIRM_LOGOUT, style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - delegate
    func sectionViewDidTapped(_ settingSectionView: SettingSectionView) {
        guard let navigationController = navigationController, let title = settingSectionView.title.text else { return }
        switch title {
        case Constants.MODITY_NAME:
            print("1")
        case Constants.ADVISE_FEEDBACK:
            navigationController.pushViewController(FeedBackViewController(), animated: true)
        case Constants.SAVE_ORIGINAL:
            if UserDefaults.standard.bool(forKey: Constants.IS_SAVE_ORIGINAL_KEY) {
                UserDefaults.standard.set(false, forKey: Constants.IS_SAVE_ORIGINAL_KEY)
            } else {
                UserDefaults.standard.set(true, forKey: Constants.IS_SAVE_ORIGINAL_KEY)
            }
            updateSaveOriginalSectionUI()
        case Constants.CLEAR_CACHE:
            showClearActionSheet()
        default:
            break
        }
    }

}
