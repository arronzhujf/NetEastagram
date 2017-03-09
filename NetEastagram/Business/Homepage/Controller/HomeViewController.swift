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
        showPhotoCacheData()
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
            if let photoList = photoList, photoList.photolist.count > 0 {
                self?.dataSource = photoList.photolist
                self?.cachePhotoData(photoList.photolist)
                self?.tableView.reloadData()
                self?.header.endRefreshing()
                if let hud = self?.hud {
                    hud.hide(animated: true)
                }
            }
        }) { [weak self] (error) in
            self?.hud?.mode = .text
            self?.hud?.label.text = Constants.NETWORK_ERROR
            self?.hud?.hide(animated: true, afterDelay: 2.0)
        }
    }
    
    @objc private func pullUpRefresh() {
        //由于大作业给的服务器只有三个景点的数据所以这里的上拉刷新只做一个界面的效果
        self.footer.endRefreshingWithNoMoreData()
    }
    
    private func showPhotoCacheData() {
        guard let photoJSONArray = UserDefaults.standard.value(forKey: Constants.PHOTO_CACHE_KEY) as? [String] else { return }
        var photoArray: [PhotoDataModel] = []
        for item in photoJSONArray {
            if let dataModel = PhotoDataModel.deserialize(from: item) {
                photoArray.append(dataModel)
            }
        }
        dataSource = photoArray
        tableView.reloadData()
    }
    
    private func cachePhotoData(_ data: [PhotoDataModel]) {
        var photoJSONArray: [String] = []
        for photoData in data {
            if let str = photoData.toJSONString() {
                photoJSONArray.append(str)
            }
        }
        UserDefaults.standard.set(photoJSONArray, forKey: Constants.PHOTO_CACHE_KEY)
    }
    
    //MARK: - lazy init
    override func creatTableView() -> UITableView {
        let res = super.creatTableView()
        res.frame = CGRect(x: margin, y: 0, width: Constants.SCREEN_WIDTH - 2*margin, height: Constants.SCREEN_HEIGHT-statusBarHeight-naviBarHeight-tabBarHeight)
        header.setRefreshingTarget(self, refreshingAction: #selector(requestPhotos))
        footer.setRefreshingTarget(self, refreshingAction: #selector(pullUpRefresh))
        res.mj_header = header
        res.mj_footer = footer
        return res
    }
}

