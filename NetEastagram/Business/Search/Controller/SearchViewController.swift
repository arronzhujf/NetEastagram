//
//  SearchViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/1.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    public static let cellIdentifier = "searchCellIdentifier"
    private let searchController = UISearchController(searchResultsController: nil)
    private lazy var tableView: UITableView = self.createTableView()
    private var dataSource = [PhotoDataModel]()
    private var filteredData = [PhotoDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initInternal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let userID = SharedPreferences.shared().userID {
            dataSource = DBManager.sharedManager().allMarks(of: userID)
            tableView.reloadData()
        }
    }
    
    //MARK: - private
    private func initInternal() {
        navigationItem.title = Constants.SEARCH
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = []
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchViewController.cellIdentifier)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.sizeToFit()
        view.addSubview(tableView)
    }
    
    private func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredData = dataSource.filter { photo in
            return photo.location.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    //MARK: - lazy init
    public func createTableView() -> UITableView {
        let res = UITableView(frame: CGRect(x: 0, y: 0, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT-statusBarHeight-naviBarHeight), style: .plain)
        res.delegate = self
        res.dataSource = self
        res.separatorStyle = .none
        return res
    }
    
    //MARK: - tableview delegate & datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive, searchController.searchBar.text != "" {
            return filteredData.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchViewController.cellIdentifier, for: indexPath) as! SearchTableViewCell
        if searchController.isActive, searchController.searchBar.text != "" {
            cell.photoDataModel = filteredData[indexPath.row]
        } else {
            cell.photoDataModel = dataSource[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        if searchController.isActive, searchController.searchBar.text != "" {
            detailViewController.model = filteredData[indexPath.row]
        } else {
            detailViewController.model = dataSource[indexPath.row]
        }
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 39
    }
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
