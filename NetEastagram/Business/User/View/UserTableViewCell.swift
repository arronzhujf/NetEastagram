//
//  UserTableViewCell.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/5.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
