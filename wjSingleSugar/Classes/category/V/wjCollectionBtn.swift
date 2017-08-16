//
//  wjCollectionBtn.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjCollectionBtn: UIButton {

    var group: wjGroupModel? {
        didSet {
            let url = group!.icon_url
            imageView?.kf.setImage(with: URL(string: url!)!)
            titleLabel?.text = group!.name
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 调整图片
        imageView?.x = 10
        imageView?.y = 0
        imageView?.width = self.width - 20
        imageView?.height = imageView!.width
        // 调整文字
        titleLabel?.x = 0
        titleLabel?.y = imageView!.height
        titleLabel?.width = self.width
        titleLabel?.height = self.height - self.titleLabel!.y
    }


}
