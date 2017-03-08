//
//  HomeViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/1.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    public static let cellIdentifier = "cellIdentifier"
    public let margin: CGFloat = 8.5
    public lazy var tableView: UITableView = self.creatTableView()
    public var dataSource: [PhotoDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
        requestPhotos()
    }
    
    //MARK: - private
    private func initInternal() {
        customBarTileViewWith(image: UIImage(named: "home-bar-icon"), title: Constants.HOME_TITLE)
        view.backgroundColor = UIColor(netHex: 0xe7e7e7)
        tableView.register(ScenicSpotCell.self, forCellReuseIdentifier: HomeViewController.cellIdentifier)
        view.addSubview(tableView)
    }
    
    private func requestPhotos() {
        let requestModel = PhotoListRequestModel(limit: 20, offset: 0)
        NetworkService.instance.requestPhotoList(with: requestModel, success: { [weak self] (photoList) in
            if let photoList = photoList {
                self?.dataSource = photoList.photolist
                self?.tableView.reloadData()
            }
        }, failure: nil)
    }
    
    //MARK: - lazy init
    private func creatTableView() -> UITableView {
         let res = UITableView(frame: CGRect(x: margin, y: 0, width: Constants.SCREEN_WIDTH - 2*margin, height: Constants.SCREEN_HEIGHT-statusBarHeight-naviBarHeight-tabBarHeight), style: .grouped)
        res.backgroundColor = UIColor(netHex: 0xe7e7e7)
        res.delegate = self
        res.dataSource = self
        res.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        res.separatorStyle = .none
        return res
    }

    //MARK: - tableview delegate & datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.cellIdentifier, for: indexPath) as! ScenicSpotCell
        cell.photoDataModel = dataSource[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 8.5
        }
        return 1.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 14))
        header.backgroundColor = view.backgroundColor
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width, height: 14))
        footer.backgroundColor = view.backgroundColor
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationController = navigationController else { return }
        let detailViewController = DetailViewController(nibName: nil, bundle: nil)
        detailViewController.model = dataSource[indexPath.section]
        navigationController.pushViewController(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

