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
    public lazy var tableView: UITableView = self.creatTableView()
    public var dataSource: [ScenicSpot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    //MARK: - private
    private func initInternal() {
        customBarTileViewWith(image: UIImage(named: "home-bar-icon"), title: Constants.HOME_TITLE)
        tableView.register(ScenicSpotCell.self, forCellReuseIdentifier: HomeViewController.cellIdentifier)
        let spot = ScenicSpot(sharedPeopleID: "ID", chineseName: "景点", englishName: "spot", bestTime: "2017.3.12", image: UIImage(named: "pho-1")!, location: "稻城亚丁", recommendReason: "无脑安利")
        dataSource.append(spot)
        dataSource.append(spot)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - lazy init
    private func creatTableView() -> UITableView {
         let res = UITableView()
        res.backgroundColor = UIColor(netHex: 0xe7e7e7)
        res.delegate = self
        res.dataSource = self
        return res
    }

    //MARK: - tableview delegate & datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewController.cellIdentifier, for: indexPath) as! ScenicSpotCell
        cell.scenicSpotModel = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}

