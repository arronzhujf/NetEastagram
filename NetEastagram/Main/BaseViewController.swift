//
//  BaseViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/3.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    public var tabBarHeight: CGFloat = 0
    public var naviBarHeight: CGFloat = 0
    public var statusBarHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        customInternal()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTabBarVisible(visible: isTabbarVisible(), animated: true) { (Bool) in
        }
    }
    
    //MARK: - private
    public func isTabbarVisible() -> Bool {
        return true
    }
    
    private func customInternal() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        edgesForExtendedLayout = [.bottom, .top]
        automaticallyAdjustsScrollViewInsets = false
        tabBarHeight = tabBarController?.tabBar.height ?? 0
        naviBarHeight = navigationController?.navigationBar.height ?? 0
        statusBarHeight = UIApplication.shared.statusBarFrame.height
        let backItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    //MARK: - tabbar utils
    
    // pass a param to describe the state change, an animated flag and a completion block matching UIView animations completion
    private func setTabBarVisible(visible: Bool, animated: Bool, completion:@escaping (Bool)->Void) {
        guard let tabBarController = tabBarController else { return }
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) {
            return completion(true)
        }
        
        // get a frame calculation ready
        let height = tabBarController.tabBar.height
        let offsetY = (visible ? -height : height)
        
        // zero duration means no animation
        let duration = (animated ? 0.3 : 0.0)
        
        UIView.animate(withDuration: duration, animations: { 
            let frame = tabBarController.tabBar.frame
            tabBarController.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
        }, completion: completion)
    }
    
    private func tabBarIsVisible() -> Bool {
        guard let tabBarController = tabBarController else { return false }
        return tabBarController.tabBar.frame.origin.y < view.frame.maxY
    }

    //MARK: - custom bar titleview
    func customBarTileViewWith(image: UIImage?, title: String) {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 18))
        let leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        leftImageView.image = image
        let rightLabel = UILabel(frame: CGRect(x: 22, y: 0, width: 38, height: 18))
        rightLabel.text = title
        rightLabel.textColor = .white
        rightLabel.font = UIFont.systemFont(ofSize: 18.0)
        titleView.addSubview(leftImageView)
        titleView.addSubview(rightLabel)
        navigationItem.titleView = titleView
    }
}
