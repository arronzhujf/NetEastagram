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

class EditInfoView: UIView, UITextFieldDelegate, UITextViewDelegate {
    public var type: EditInfoViewType = .horizonType {
        didSet {
            adjustView(by: type)
        }
    }
    public lazy var titleLabel: UILabel = self.createTitleLabel()
    public lazy var horizonTextField: UITextField = self.createHorizonTextField()
    public lazy var verticalTextView: UITextView = self.createverticalTextView()
    
    private func adjustView(by type: EditInfoViewType) {
        addSubview(titleLabel)
        if type == .horizonType {
            addSubview(horizonTextField)
            let bottomLine = UIView()
            bottomLine.backgroundColor = Constants.LIGHT_GRAY_COLOR
            addSubview(bottomLine)
            
            titleLabel.snp.makeConstraints({ (make) in
                make.left.centerY.equalToSuperview()
                make.width.equalTo(80)
            })
            horizonTextField.snp.makeConstraints({ (make) in
                make.left.equalTo(titleLabel.snp.right)
                make.centerY.right.equalToSuperview()
            })
            bottomLine.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(1.0)
            })
            
        } else if type == .verticalType {
            addSubview(verticalTextView)
            titleLabel.snp.makeConstraints({ (make) in
                make.left.equalToSuperview()
                make.top.equalToSuperview().offset(10.0)
            })
            verticalTextView.snp.makeConstraints({ (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(10.0)
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
        res.textAlignment = .left
        res.font = UIFont.systemFont(ofSize: 16.0)
        res.delegate = self
        res.clearButtonMode = .whileEditing
        return res
    }
    
    private func createverticalTextView() -> UITextView {
        let res = UITextView()
        res.layer.borderColor = Constants.TEXT_GRAY_COLOR.cgColor
        res.font = UIFont.systemFont(ofSize: 16.0)
        res.layer.borderWidth = 1.0
        res.layer.cornerRadius = 5.0
        res.delegate = self
        return res
    }
    
    //MARK: - delegate    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
