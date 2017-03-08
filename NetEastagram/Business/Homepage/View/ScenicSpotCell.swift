//
//  ScenicSpotCell.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/3/4.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class ScenicSpotCell: UITableViewCell {
    public var photoDataModel: PhotoDataModel? {
        didSet {
            configCellWith(model: photoDataModel)
        }
    }
    public var headImage: UIImageView
    public var headLabel: UILabel
    public var bottomContainer: UIView
    public var timeLabel: UILabel
    public var bottomLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        headImage = UIImageView()
        headLabel = UILabel()
        bottomContainer = UIView()
        timeLabel = UILabel()
        bottomLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.customInternal()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    //MARK : private
    func customInternal() {
        contentView.backgroundColor = UIColor(netHex: 0xe7e7e7)
        headLabel.font = UIFont.systemFont(ofSize: 18.0)
        headLabel.textColor = .white
        bottomContainer.backgroundColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 13.0)
        timeLabel.textColor = UIColor(netHex: 0xfeae53)
        bottomLabel.font = UIFont.systemFont(ofSize: 12.0)
        bottomLabel.textColor = Constants.LIGHT_GRAY_COLOR
        contentView.addSubview(headImage)
        contentView.addSubview(headLabel)
        contentView.addSubview(bottomContainer)
        bottomContainer.addSubview(timeLabel)
        bottomContainer.addSubview(bottomLabel)
        
        headImage.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(bottomContainer.snp.top)
        }
        headLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12.5)
            make.bottom.equalTo(headImage).offset(-12.5)
        }
        bottomContainer.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(74)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(13)
            make.centerY.equalToSuperview().offset(-10)
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel)
            make.centerY.equalToSuperview().offset(10)
        }
    }
    
    func configCellWith(model: PhotoDataModel?) {
        guard let model = model else { return }
        headImage.sd_setImage(with: URL(string: model.imageUrl))
        headLabel.text = model.title
        timeLabel.text = model.photoNo
        bottomLabel.text = model.location
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
