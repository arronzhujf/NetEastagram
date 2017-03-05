//
//  MainTabBarViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/1.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initTabbar()
    }

    private func initTabbar() {
        if let items = tabBar.items {
            items[0].image = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysOriginal)
            items[0].selectedImage = #imageLiteral(resourceName: "home-pre").withRenderingMode(.alwaysOriginal)
            items[1].image = #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal)
            items[1].selectedImage = #imageLiteral(resourceName: "search-pre").withRenderingMode(.alwaysOriginal)
            items[2].image = #imageLiteral(resourceName: "camera").withRenderingMode(.alwaysOriginal)
            items[2].selectedImage = #imageLiteral(resourceName: "camera-pre").withRenderingMode(.alwaysOriginal)
            items[3].image = #imageLiteral(resourceName: "me").withRenderingMode(.alwaysOriginal)
            items[3].selectedImage = #imageLiteral(resourceName: "me-pre").withRenderingMode(.alwaysOriginal)
        }
    }
}
