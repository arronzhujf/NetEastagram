//
//  FeedBackViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/22.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

class FeedBackViewController: BaseViewController {
    private var adviseText: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    override func isTabbarVisible() -> Bool {
        return false;
    }
    
    //MARK: - private
    private func initInternal() {
        navigationItem.title = Constants.FEEDBACK
    }
}
