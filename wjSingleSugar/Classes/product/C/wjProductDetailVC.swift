//
//  wjProductDetailVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjProductDetailVC: wjMainBaseVC {
    // 属性
    var model : wjProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjNavigationSettings()
    }
}

// MARK:- 界面搭建
extension wjProductDetailVC {
    func wjNavigationSettings() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named : "GiftShare_icon_18x22_"), style: .plain, target: self, action: #selector(self.wjShareAction))
    }
    
    // 基本界面的搭建
    func wjDetailUISettings() {
        
    }
    
    
}


// MARK:- 按钮的点击事件
extension wjProductDetailVC {
    // 分享按钮的点击事件
    func wjShareAction() {
        
    }
}
