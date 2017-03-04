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
    public var dataSource: [ScenicSpot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    //MARK: - private
    private func initInternal() {
        customBarTileViewWith(image: UIImage(named: "home-bar-icon"), title: Constants.HOME_TITLE)
        view.backgroundColor = UIColor(netHex: 0xe7e7e7)
        tableView.register(ScenicSpotCell.self, forCellReuseIdentifier: HomeViewController.cellIdentifier)
        let spot = ScenicSpot(sharedPeopleID: "ID", chineseName: "景点", englishName: "spot", bestTime: "2017.3.12", image: UIImage(named: "pho-1")!, location: "稻城亚丁", recommendReason: "无脑安利")
        dataSource.append(spot)
        dataSource.append(spot)
        view.addSubview(tableView)
    }
    
    //MARK: - lazy init
    private func creatTableView() -> UITableView {
         let res = UITableView(frame: CGRect(x: margin, y: 0, width: Constants.SCREEN_WIDTH - 2*margin, height: Constants.SCREEN_HEIGHT - tabBarHeight), style: .grouped)
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
        cell.scenicSpotModel = dataSource[indexPath.section]
        let shapeLayer = CAShapeLayer()
        let bezierPath = UIBezierPath(roundedRect: cell.bounds.insetBy(dx: 0.0,dy: 2.0), cornerRadius: 5.0)
        shapeLayer.path = bezierPath.cgPath
        cell.layer.mask = shapeLayer
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
        return 13
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
}

