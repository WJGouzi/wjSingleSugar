//
//  wjProductDetailToolBar.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

protocol wjProductDetailToolBarDelegate : NSObjectProtocol {
    func wjGotoTmallClickAction()
}

class wjProductDetailToolBar: UIView {

    // 属性
    weak var delegate : wjProductDetailToolBarDelegate?
    
    @IBOutlet weak var likedBtn: UIButton!
    @IBAction func likedBtnClickAction(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: isLogin) {
            // 登录
            
        } else {
            likedBtn.isSelected = true
        }
    }

    @IBAction func goToTmallClickAction(_ sender: UIButton) {
        delegate?.wjGotoTmallClickAction()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likedBtn.layer.borderColor = wjGlobalRedColor().cgColor
        likedBtn.layer.borderWidth = klineWidth
        likedBtn.setImage(UIImage(named: "content-details_like_16x16_"), for: .normal)
        likedBtn.setImage(UIImage(named: "content-details_like_selected_16x16_"), for: .selected)
    }
    
}
