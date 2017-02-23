//
//  ShootViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/1.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class ShootViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    //MARK: - private
    private func initInternal() {
        customBarTileViewWith(image: UIImage(named: "shoot-bar-icon"), title: Constants.SHOOT_TITLE)
    }

}
