//
//  ImageTopLabelBottomButton.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/26.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class ImageTopLabelBottomButton: UIButton {
    public var interval: CGFloat = 0

    override func layoutSubviews() {
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        super.layoutSubviews()
        
        // Center image
        var center = imageView.center
        center.x = width/2;
        center.y = imageView.height/2;
        imageView.center = center;
        
        //Center text
        var newFrame = titleLabel.frame
        newFrame.origin.x = 0
        newFrame.origin.y = imageView.height + interval
        newFrame.size.width = width
        newFrame.size.height = height - newFrame.origin.y
        titleLabel.frame = newFrame
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
    }
}
