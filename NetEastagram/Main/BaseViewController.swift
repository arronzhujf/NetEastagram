//
//  BaseViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/3.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = [.bottom]
        automaticallyAdjustsScrollViewInsets = false
    }

    override func viewWillAppear(_ animated: Bool) {
        setTabBarVisible(visible: isTabbarVisible(), animated: true) { (Bool) in
            
        }
    }
    
    public func isTabbarVisible() -> Bool {
        return true
    }
    
    //MARK: - tabbar utils
    
    // pass a param to describe the state change, an animated flag and a completion block matching UIView animations completion
    func setTabBarVisible(visible: Bool, animated: Bool, completion:@escaping (Bool)->Void) {
        
        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) {
            return completion(true)
        }
        
        // get a frame calculation ready
        let height = tabBarController!.tabBar.frame.size.height
        let offsetY = (visible ? -height : height)
        
        // zero duration means no animation
        let duration = (animated ? 0.3 : 0.0)
        
        UIView.animate(withDuration: duration, animations: { 
            let frame = self.tabBarController!.tabBar.frame
            self.tabBarController!.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
        }, completion: completion)
    }
    
    func tabBarIsVisible() -> Bool {
        return tabBarController!.tabBar.frame.origin.y < view.frame.maxY
    }

}
