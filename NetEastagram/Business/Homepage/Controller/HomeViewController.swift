//
//  HomeViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/1.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import MJRefresh
import MBProgressHUD

class HomeViewController: PhotoTableBaseViewController {
    //refresh
    private let header = MJRefreshNormalHeader()
    private let footer = MJRefreshAutoNormalFooter()
    
    //progressHUD
    private var hud: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPhotos(withHud: true)
    }
    
    //MARK: - private
    override func initInternal() {
        super.initInternal()
        customBarTileViewWith(image: UIImage(named: "home-bar-icon"), title: Constants.HOME_TITLE)
    }
    
    @objc private func requestPhotos(withHud show: Bool) {
        if show {
            hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud?.mode = .indeterminate
        }
        let requestModel = PhotoListRequestModel(limit: 20, offset: 0)
        NetworkService.sharedService().requestPhotoList(with: requestModel, success: { [weak self] (photoList) in
            if let photoList = photoList {
                self?.dataSource = photoList.photolist
                self?.tableView.reloadData()
                self?.header.endRefreshing()
                if let hud = self?.hud {
                    hud.hide(animated: true)
                }
            }
        }, failure: nil)
    }
    
    @objc private func pullUpRefresh() {
        //由于大作业给的服务器只有三个景点的数据所以这里的上拉刷新只做一个界面的效果
        self.footer.endRefreshingWithNoMoreData()
    }
    
    //MARK: - lazy init
    override func creatTableView() -> UITableView {
        let res = super.creatTableView()
        header.setRefreshingTarget(self, refreshingAction: #selector(requestPhotos))
        footer.setRefreshingTarget(self, refreshingAction: #selector(pullUpRefresh))
        res.mj_header = header
        res.mj_footer = footer
        return res
    }
}

