//
//  SearchTableViewCell.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/9.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    public var photoDataModel: PhotoDataModel? {
        didSet {
            configCellWith(model: photoDataModel)
        }
    }
    
    private let leftImageView: UIImageView
    private let rightArrowImageView: UIImageView
    private let contentLabel: UILabel
    private let bottomLine: UIView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        leftImageView = UIImageView()
        rightArrowImageView = UIImageView()
        contentLabel = UILabel()
        bottomLine = UIView()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        customInternal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - private
    func customInternal() {
        leftImageView.image = UIImage(named: "search-location")
        rightArrowImageView.image = UIImage(named: "me-arrow")
        bottomLine.backgroundColor = Constants.LIGHT_GRAY_COLOR
        contentLabel.font = UIFont.systemFont(ofSize: 13.0)
        contentLabel.textColor = Constants.TEXT_GRAY_COLOR
        contentView.addSubview(leftImageView)
        contentView.addSubview(rightArrowImageView)
        contentView.addSubview(bottomLine)
        contentView.addSubview(contentLabel)
        
        leftImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(26.0)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.6)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.4)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(leftImageView.snp.right).offset(9.0)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(1.0)
        }
        
        rightArrowImageView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8.0)
            make.width.equalTo(rightArrowImageView.snp.height).multipliedBy(0.5)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bottomLine).offset(30)
            make.centerY.equalToSuperview()
        }
    }
    
    func configCellWith(model: PhotoDataModel?) {
        guard let model = model else { return }
        contentLabel.text = model.location + "       " + model.province
    }
}
