//
//  Constants.swift
//  NetEastagram
//
//  Created by JianfengZhu on 2017/2/4.
//  Copyright © 2017年 JianfengZhu. All rights reserved.
//

import UIKit

struct Constants {
    static let SCREEN_WIDTH = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.height
    
    //MARK: - color
    static let LIGHT_GRAY_COLOR = UIColor(netHex: 0xacacac)
    static let TEXT_GRAY_COLOR = UIColor(netHex: 0x999999)
    
    //MARK: - label
    static let CANCEL = "取消"
    static let HOME_TITLE = "热门"
    static let DETAILS = "详情"
    static let POST = "发布"
    static let RETURN = "返回"
    static let SHOOT = "拍照"
    static let ALBUM = "相册"
    static let EDIT = "编辑"
    static let USER_TITLE = "我的"
    static let SET = "设置"
    static let DOWNLOAD = "下载"
    static let MY_POST = "我的发布:"
    static let MY_MARK = "我的收藏"
    static let MARK = "收藏"
    static let MY_FAVORITE = "我的偏好:"
    static let INVITE = "邀请好友:"
    static let MODITY_NAME = "修改用户名:"
    static let ADVISE_FEEDBACK = "意见反馈:"
    static let FEEDBACK = "反馈"
    static let FEEDBACK_HEAD_TEXT = "写点什么给我们"
    static let SAVE_ORIGINAL = "保存原始图片:"
    static let CLEAR_CACHE = "清除缓存:"
    static let CONFIRM_CLEAR = "确认清除"
    static let CONFIRM_LOGOUT = "确认退出"
    static let SHOOT_CITY = "拍摄城市:"
    static let SHOOT_SPOT = "拍摄景点:"
    static let ADD_DESC = "添加描述:"
    
    //MARK: - data persistence
    static let IS_LOGIN_KEY = "isLoginKey"
    static let IS_SAVE_ORIGINAL_KEY = "isSaveOriginalKey"
}
