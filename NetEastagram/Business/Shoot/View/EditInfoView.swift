//
//  EditInfoView.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/27.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

enum EditInfoViewType {
    case horizonType
    case verticalType
}

class EditInfoView: UIView {
    public var type: EditInfoViewType = .horizonType {
        didSet {
            adjustView(by: type)
        }
    }
    public lazy var titleLabel: UILabel = self.createTitleLabel()
    private lazy var horizonTextField: UITextField = self.createHorizonTextField()
    private lazy var verticalTextView: UITextView = self.createverticalTextView()
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initInternal()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        return nil
//    }
//    
//    //MARK: - private
//    private func initInternal() {
//    }
    
    private func adjustView(by type: EditInfoViewType) {
        addSubview(titleLabel)
        if type == .horizonType {
            addSubview(horizonTextField)
            let bottomLine = UIView(frame: CGRect(x: 0, y: height-1, width: width, height: 1))
            bottomLine.backgroundColor = Constants.LIGHT_GRAY_COLOR
            addSubview(bottomLine)
            
            titleLabel.snp.makeConstraints({ (make) in
                make.left.centerY.equalToSuperview()
//                make.width.equalTo(120)
            })
            horizonTextField.snp.makeConstraints({ (make) in
                make.left.equalTo(titleLabel.snp.right)
                make.centerY.right.equalToSuperview()
            })
            
        } else if type == .verticalType {
            addSubview(verticalTextView)
            titleLabel.snp.makeConstraints({ (make) in
                make.top.left.equalToSuperview()
            })
            verticalTextView.snp.makeConstraints({ (make) in
                make.top.equalTo(titleLabel.snp.bottom)
                make.left.bottom.right.equalToSuperview()
            })
        }
    }
    
    //MARK: - lazy init
    private func createTitleLabel() -> UILabel {
        let res = UILabel()
        res.font = UIFont.systemFont(ofSize: 16.0)
        res.textColor = Constants.TEXT_GRAY_COLOR
        return res
    }
    
    private func createHorizonTextField() -> UITextField {
        let res = UITextField()
        res.textColor = Constants.TEXT_GRAY_COLOR
        res.textAlignment = .left
        res.font = UIFont.systemFont(ofSize: 16.0)
        return res
    }
    
    private func createverticalTextView() -> UITextView {
        let res = UITextView()
        res.layer.borderColor = Constants.TEXT_GRAY_COLOR.cgColor
        res.layer.borderWidth = 1.0
        res.layer.cornerRadius = 5.0
        return res
    }
    
}
