//
//  wjDetailScrollView.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit

class wjDetailScrollView: UIScrollView {

    // 属性
    var product : wjProductModel? {
        didSet {
            wjTopView.productItem = product
            wjBottomView.item = product
        }
    }
    
    
    // 懒加载
    lazy var wjTopView : wjDetailTopScrollView = {
        let topView = wjDetailTopScrollView()
        topView.backgroundColor = UIColor.white
        return topView
    }()
    
    lazy var wjBottomView : wjDetailBottomView = {
        let bottomView = wjDetailBottomView()
        bottomView.backgroundColor = UIColor.white
        return bottomView
    }()
    
    
    
    // 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        wjSetUpUISettings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 创建UI界面
extension wjDetailScrollView {
    func wjSetUpUISettings() {
        addSubview(wjTopView)
        addSubview(wjBottomView)
        // 约束
        wjTopView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSize(width: SCREENW, height: 520))
        }
        
        wjBottomView.snp.makeConstraints { (make) in
            make.top.equalTo(wjTopView.snp.bottom).offset(kMargin)
            make.left.equalTo(self)
            make.size.equalTo(CGSize(width: SCREENW, height: SCREENH - 64 - 45))
        }
        
    }
}

