//
//  FeedBackViewController.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/22.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class FeedBackViewController: BaseViewController, UITextViewDelegate {
    private var adviseText: UITextView!
    private var sendBtn: UIButton!

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
        let headLabel = UILabel()
        headLabel.text = Constants.FEEDBACK_HEAD_TEXT
        headLabel.textColor = Constants.TEXT_GRAY_COLOR
        headLabel.font = UIFont.systemFont(ofSize: 13.0)
        
        adviseText = UITextView()
        adviseText.layer.borderColor = Constants.TEXT_GRAY_COLOR.cgColor
        adviseText.layer.borderWidth = 1.0
        adviseText.layer.cornerRadius = 5.0
        adviseText.delegate = self
        
        sendBtn = UIButton()
        sendBtn.setBackgroundImage(UIImage(named: "me-send-light"), for: .normal)
        
        view.addSubview(headLabel)
        view.addSubview(adviseText)
        view.addSubview(sendBtn)
        
        headLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(17.5)
            make.top.equalToSuperview().offset(20)
        }
        
        adviseText.snp.makeConstraints { (make) in
            make.left.equalTo(headLabel)
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-17.5)
            make.height.equalTo(134)
        }
        
        sendBtn.snp.makeConstraints { (make) in
            make.height.equalTo(36)
            make.width.equalTo(88)
            make.right.equalTo(adviseText)
            make.top.equalTo(adviseText.snp.bottom).offset(38)
        }
    }
    
    //MARK: - UITextView delegate
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.characters.count > 0 {
            sendBtn.setBackgroundImage(UIImage(named: "me-send"), for: .normal)
        } else {
            sendBtn.setBackgroundImage(UIImage(named: "me-send-light"), for: .normal)
        }
    }
}
