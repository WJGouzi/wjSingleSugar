//
//  wjStyleAndClassView.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//  品类和风格的视图

import UIKit
import SnapKit

protocol wjStyleAndClassDelegate : NSObjectProtocol {
    func wjStyleAndClassViewButtonDidClicked(button : UIButton)
}


class wjStyleAndClassView: UIView {
   
    var groups = [AnyObject]()
    var delegate : wjStyleAndClassDelegate?
    
    lazy var titleView : UIView = {
        let titleV = UIView()
        titleV.backgroundColor = UIColor.white
        return titleV
    }()
    
    lazy var titleLabel : UILabel = {
        let titleL = UILabel()
        titleL.font = UIFont.systemFont(ofSize: 16.0)
        titleL.textColor = UIColor.gray
        titleL.text = "风格"
        return titleL
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /// 分类界面 风格,品类
        weak var weakSelf = self
        wjNetworkTool.shareNetwork.wjLoadStyleAndClassData { (channelGroups) in
            weakSelf!.groups = channelGroups
            weakSelf!.wjSetUpUI()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// 搭建UI界面
extension wjStyleAndClassView {
    func wjSetUpUI() {
        let topGroups = groups[0] as! NSArray
        let bottomGroups = groups[1] as! NSArray
        
        // 风格
        let topView = UIView()
        topView.width = SCREENW
        topView.backgroundColor = UIColor.white
        addSubview(topView)
        let styleLabel = setupLabel(title: "风格")
        topView.addSubview(styleLabel)
        
        for index in 0..<topGroups.count {
            let group = topGroups[index] as! wjGroupModel
            let button = setupButton(index: index, group: group)
            topView.addSubview(button)
            if index == topGroups.count - 1 {
                topView.height = button.frame.maxY + kMargin
            }
        }
        
        // 品类
        let bottomView = UIView()
        bottomView.width = SCREENW
        bottomView.y = topView.frame.maxY + kMargin
        bottomView.backgroundColor = UIColor.white
        addSubview(bottomView)
        let categoryLabel = setupLabel(title: "品类")
        bottomView.addSubview(categoryLabel)
        
        for index in 0..<bottomGroups.count {
            let group = bottomGroups[index] as! wjGroupModel
            let button = setupButton(index: index, group: group)
            bottomView.addSubview(button)
            if index == bottomGroups.count - 1 {
                bottomView.height = button.frame.maxY + kMargin
            }
        }
    }
    
    // 标签view
    func setupLabel(title: String) -> UILabel {
        let styleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: SCREENW - 10, height: 40))
        styleLabel.text = title
        styleLabel.textColor = wjColor(r: 0, g: 0, b: 0, a: 0.6)
        styleLabel.font = UIFont.systemFont(ofSize: 16)
        return styleLabel
    }
    
    func setupButton(index: Int, group: wjGroupModel) -> wjCollectionBtn{
        let buttonW: CGFloat = SCREENW / 4
        let buttonH: CGFloat = buttonW
        let styleLabelH: CGFloat = 40
        
        let button = wjCollectionBtn()
        button.width = buttonW
        button.height = buttonH
        button.x = buttonW * CGFloat(index % 4)
        button.y = buttonH * CGFloat(index / 4) + styleLabelH
        if index > 3 {
            button.y = buttonH * CGFloat(index / 4) + styleLabelH + kMargin
        }
        button.tag = group.id!
        button.addTarget(self, action: #selector(groupButonClick), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(wjColor(r: 0, g: 0, b: 0, a: 0.6), for: .normal)
        button.kf.setImage(with: URL(string: group.icon_url!)!, for: .normal)
        button.setTitle(group.name, for: .normal)
        return button
    }
}

// 点击事件
extension wjStyleAndClassView {
    func groupButonClick(button: UIButton) {
        print(button.tag)
        delegate?.wjStyleAndClassViewButtonDidClicked(button: button)
    }
}

