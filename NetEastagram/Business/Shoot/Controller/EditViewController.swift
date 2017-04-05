//
//  EditViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/27.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class EditViewController: BaseViewController, UIScrollViewDelegate {
    public var image: UIImage? = nil
    private lazy var scrollView: UIScrollView = self.createScrollView()
    private lazy var headImageView: UIImageView = self.createHeadImageView()
    private let shootCityCell: EditInfoView
    private let shootSpotCell: EditInfoView
    private let addDescCell: EditInfoView
    private let returnBtn: ImageTopLabelBottomButton
    private let forwardBtn: ImageTopLabelBottomButton
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        shootCityCell = EditInfoView()
        shootSpotCell = EditInfoView()
        addDescCell = EditInfoView()
        returnBtn = ImageTopLabelBottomButton()
        forwardBtn = ImageTopLabelBottomButton()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)

        initInternal()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shootCityCell.horizonTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize.height = max(returnBtn.frame.maxY + 100, scrollView.height+1)
    }

    //MARK: - private
    private func initInternal() {
        //custom bar
        navigationItem.title = Constants.EDIT
        let closeBtn = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(closeBtnClick(_:)))
        closeBtn.imageInsets = UIEdgeInsetsMake(5, 5, 5, 5)
        navigationItem.rightBarButtonItem = closeBtn
        
        headImageView.image = image
        let intervalLine = UIView(frame: CGRect(x: 0, y: headImageView.frame.maxY+23, width: Constants.SCREEN_WIDTH, height: 1))
        intervalLine.backgroundColor = Constants.LIGHT_GRAY_COLOR
        
        shootCityCell.type = .horizonType
        shootCityCell.titleLabel.text = Constants.SHOOT_CITY
        shootSpotCell.type = .horizonType
        shootSpotCell.titleLabel.text = Constants.SHOOT_SPOT
        addDescCell.type = .verticalType
        addDescCell.titleLabel.text = Constants.ADD_DESC
        
        returnBtn.setImage(UIImage(named: "shoot-edit-return"), for: .normal)
        returnBtn.setImage(UIImage(named: "shoot-edit-return-light"), for: .highlighted)
        returnBtn.setTitle(Constants.RETURN, for: .normal)
        returnBtn.setTitleColor(Constants.TEXT_GRAY_COLOR, for: .normal)
        returnBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        returnBtn.addTarget(self, action: #selector(returnBtnClick(_:)), for: .touchUpInside)
        
        forwardBtn.setImage(UIImage(named: "shoot-edit-forward"), for: .normal)
        forwardBtn.setImage(UIImage(named: "shoot-edit-forward-light"), for: .highlighted)
        forwardBtn.setTitle(Constants.POST, for: .normal)
        forwardBtn.setTitleColor(Constants.TEXT_GRAY_COLOR, for: .normal)
        forwardBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        forwardBtn.addTarget(self, action: #selector(forwardBtnClick(_:)), for: .touchUpInside)
        
        scrollView.addSubview(headImageView)
        scrollView.addSubview(intervalLine)
        scrollView.addSubview(shootCityCell)
        scrollView.addSubview(shootSpotCell)
        scrollView.addSubview(addDescCell)
        scrollView.addSubview(returnBtn)
        scrollView.addSubview(forwardBtn)
        view.addSubview(scrollView)
    
        shootCityCell.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.SCREEN_WIDTH-50)
            make.height.equalTo(37)
            make.centerX.equalToSuperview()
            make.top.equalTo(intervalLine.snp.bottom)
        }
        
        shootSpotCell.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(shootCityCell)
            make.top.equalTo(shootCityCell.snp.bottom)
        }

        addDescCell.snp.makeConstraints { (make) in
            make.left.right.equalTo(shootCityCell)
            make.top.equalTo(shootSpotCell.snp.bottom)
            make.height.equalTo(166)
        }
        
        returnBtn.snp.makeConstraints { (make) in
            make.height.equalTo(68)
            make.width.equalTo(36)
            make.top.equalTo(addDescCell.snp.bottom).offset(67)
            make.left.equalToSuperview().offset(62)
        }
        
        forwardBtn.snp.makeConstraints { (make) in
            make.width.height.top.equalTo(returnBtn)
            make.right.equalTo(Constants.SCREEN_WIDTH - 62)
        }
    }
    
    //MARK: - action
    @objc func closeBtnClick(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func returnBtnClick(_ sender: ImageTopLabelBottomButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func forwardBtnClick(_ sender: ImageTopLabelBottomButton) {
    }
    

    //MARK: - lazy init
    private func createScrollView() -> UIScrollView {
        let res = UIScrollView(frame: view.bounds)
        res.backgroundColor = .white
        res.contentSize = CGSize(width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_HEIGHT*2)
        res.showsHorizontalScrollIndicator = false
        res.showsVerticalScrollIndicator = false
        res.delegate = self
        return res
    }
    
    private func createHeadImageView() -> UIImageView {
        let res = UIImageView(frame: CGRect(x: 0, y: 23, width: Constants.SCREEN_WIDTH, height: Constants.SCREEN_WIDTH*3/4.0))
        res.backgroundColor = .white
        res.image = UIImage(named: "demo-image")
        res.contentMode = .scaleAspectFit
        return res
    }
    
    //MARK: - scrollview delegate
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    //MARK: - keyboard notification
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrameValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue, scrollView.contentInset == UIEdgeInsets.zero else { return }
        let keyboardFrame = self.view.convert(keyboardFrameValue.cgRectValue, from: nil)
        var inset = scrollView.contentInset
        inset.top-=keyboardFrame.height
        inset.bottom+=keyboardFrame.height
        scrollView.contentInset = inset
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentInset = UIEdgeInsets.zero
    }
}
