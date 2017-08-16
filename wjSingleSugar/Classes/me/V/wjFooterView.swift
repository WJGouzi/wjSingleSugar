//
//  wjFooterView.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit

class wjFooterView: UIView {

    
    lazy var heartBtn : UIButton = {
        let heartBtn = UIButton()
        heartBtn.setImage(UIImage(named : "Me_blank_50x50_"), for: .normal)
        heartBtn.imageView?.sizeToFit()
        return heartBtn
    }()
    
    lazy var textLabel : UILabel = {
        let textL = UILabel()
        textL.text = "登录->享受功能"
        textL.textColor = wjColor(r: 0, g: 0, b: 0, a: 0.2)
        textL.textAlignment = .center
        textL.font = UIFont.systemFont(ofSize: 15.0)
        return textL
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heartBtn)
        addSubview(textLabel)
        heartBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 50, height: 50))
            make.center.equalTo(self.snp.center)
        }
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(heartBtn.snp.centerX)
            make.height.equalTo(2 * kMargin)
            make.top.equalTo(heartBtn.snp.bottom).offset(kMargin)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
