//
//  wjConst.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

enum wjTopicType: Int {
    /// 精选
    case selection = 4
    /// 美食
    case food = 14
    /// 家居
    case household = 16
    /// 数码
    case digital = 17
    /// 美物
    case goodThing = 13
    /// 杂货
    case grocery = 22
}

enum wjShareButtonType: Int {
    /// 微信朋友圈
    case weChatTimeline = 0
    /// 微信好友
    case weChatSession = 1
    /// 微博
    case weibo = 2
    /// QQ 空间
    case qZone = 3
    /// QQ 好友
    case qqFriends = 4
    /// 复制链接
    case copyLink = 5
}

enum wjOtherLoginButtonType: Int {
    /// 微博
    case weiboLogin = 100
    /// 微信
    case weChatLogin = 101
    /// QQ
    case qqLogin = 102
}

/// 服务器地址
let BASE_URL = "http://api.dantangapp.com/"

/// 第一次启动
let wjFirstLaunch = "firstLaunch"
/// 是否登录
let isLogin = "isLogin"
let wjUserTelephone = "telephone"
let wjPassword = "password"



/// code 码 200 操作成功
let RETURN_OK = 200
/// 间距
let kMargin: CGFloat = 10.0
/// 圆角
let kCornerRadius: CGFloat = 5.0
/// 线宽
let klineWidth: CGFloat = 1.0
/// 首页顶部标签指示条的高度
let kIndicatorViewH: CGFloat = 2.0
/// 新特性界面图片数量
let kNewFeatureCount = 4
/// 顶部标题的高度
let kTitlesViewH: CGFloat = 35
/// 顶部标题的y
let kTitlesViewY: CGFloat = 64
/// 动画时长
let kAnimationDuration = 0.25
/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height
/// 分类界面 顶部 item 的高
let kitemH: CGFloat = 100
/// 分类界面 顶部 item 的宽
let kitemW: CGFloat = 150
/// 我的界面头部图像的高度
let kwjMineHeaderImageHeight: CGFloat = 200
// 分享按钮背景高度
let kTopViewH: CGFloat = 230


/// RGBA的颜色设置
func wjColor(r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func wjGlobalColor() -> UIColor {
    return wjColor(r:240, g: 240, b: 240, a: 1)
}

/// 红色
func wjGlobalRedColor() -> UIColor {
    return wjColor(r:245, g: 80, b: 83, a: 1.0)
}

/// iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREENH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false

