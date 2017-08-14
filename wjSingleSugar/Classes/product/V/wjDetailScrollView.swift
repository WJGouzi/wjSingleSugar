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
        }
    }
    
    
    // 懒加载
    var wjTopView : wjDetailTopScrollView = {
        let topView = wjDetailTopScrollView()
        topView.backgroundColor = UIColor.white
        return topView
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
        // 约束
        wjTopView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self)
            make.size.equalTo(CGSize(width: SCREENW, height: 520))
        }
    }
}

