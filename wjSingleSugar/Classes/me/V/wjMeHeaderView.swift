//
//  wjMeHeaderView.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit

class wjMeHeaderView: UIView {

    // 懒加载
    lazy var backImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "Me_ProfileBackground")
        return imageView
    }()

    lazy var noticeBtn : UIButton = {
        let noticeBtn = UIButton()
        noticeBtn.setImage(UIImage(named: "Me_message_20x20_"), for: .normal)
        return noticeBtn
    }()
    
    lazy var settingsBtn : UIButton = {
        let settingBtn = UIButton()
        settingBtn.setImage(UIImage(named : "Me_settings_20x20_"), for: .normal)
        return settingBtn
    }()
    
    lazy var headImageBtn : UIButton = {
        let iconBtn = UIButton()
        iconBtn.setImage(UIImage(named : "Me_AvatarPlaceholder_75x75_"), for: .normal)
        iconBtn.layer.cornerRadius = iconBtn.width * 0.5
        iconBtn.layer.masksToBounds = true
        return iconBtn
    }()
    
    lazy var nickNameLabel : UILabel = {
        let nickNameL = UILabel()
        nickNameL.text = "请输入账号名"
        nickNameL.textAlignment = .center
        nickNameL.font = UIFont.systemFont(ofSize: 15.0)
        nickNameL.textColor = wjGlobalColor()
        return nickNameL
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backImageView)
        addSubview(noticeBtn)
        addSubview(settingsBtn)
        addSubview(headImageBtn)
        addSubview(nickNameLabel)
        
        // 约束
        backImageView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(-20) // 占领状态栏
        }
        noticeBtn.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 44, height: 44))
            make.left.equalTo(self)
            make.top.equalTo(0)
        }
        settingsBtn.snp.makeConstraints { (make) in
            make.size.equalTo(noticeBtn.snp.size)
            make.right.equalTo(self)
            make.top.equalTo(noticeBtn.snp.top)
        }
        headImageBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.size.equalTo(CGSize(width: 75, height: 75))
            make.bottom.equalTo(nickNameLabel.snp.top).offset(-kMargin)
        }
        nickNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(headImageBtn.snp.centerX)
            make.height.equalTo(2 * kMargin)
            make.bottom.equalTo(self).offset(-3 * kMargin)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



