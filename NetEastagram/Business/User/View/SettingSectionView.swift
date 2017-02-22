//
//  UserSettingView.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/6.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

enum SectionType {
    case LabelType
    case SwitchType
}

protocol SettingSectionViewDelegate:  NSObjectProtocol{
    func sectionViewDidTapped(_ settingSectionView: SettingSectionView)
}

class SettingSectionView: UIView {
    weak var delegate: SettingSectionViewDelegate?
    private let type: SectionType
    public var title = UILabel()
    public var nameLabel = UILabel()
    public var switchImageView = UIImageView()
    
    init(frame: CGRect, type: SectionType) {
        self.type = type
        super.init(frame: frame)
        initInternal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    //MARK: - private
    private func initInternal() {
        addTouchEvent()
        title.textColor = Constants.GRAY_COLOR
        title.font = UIFont.systemFont(ofSize: 15.0)
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
        let bottomLine = UIView()
        bottomLine.backgroundColor = Constants.GRAY_COLOR
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        if type == .LabelType {
            nameLabel.textColor = Constants.GRAY_COLOR
            nameLabel.font = UIFont.systemFont(ofSize: 15.0)
            addSubview(nameLabel)
            let arrow = UIImageView(image: #imageLiteral(resourceName: "me-arrow"))
            addSubview(arrow)
            nameLabel.snp.makeConstraints({ (make) in
                make.right.equalTo(arrow.snp.left).offset(-21)
                make.centerY.equalToSuperview()
            })
            arrow.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(-16)
                make.centerY.equalToSuperview()
            })
        } else {
            switchImageView.image = #imageLiteral(resourceName: "me-switch")
            addSubview(switchImageView)
            switchImageView.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-16)
            })
        }
    }
    
    private func addTouchEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sectionViewTapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func sectionViewTapped() {
        if let delegate = delegate {
            delegate.sectionViewDidTapped(self)
        }
    }
}

