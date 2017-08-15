//
//  wjChoiceBtn.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/15.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

protocol wjChoiceBtnClickDelegate {
    // 图文介绍的点击事件
    func wjIntroduceClick(_ btn : UIButton)
    // 评论的点击事件
    func wjCommentClick(_ btn : UIButton)
}


class wjChoiceBtn: UIView {

    // 属性
    @IBOutlet weak var introductionBtn : UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var indicatorLineView: UIView!
    
    var delegate : wjChoiceBtnClickDelegate?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicatorLineView.backgroundColor = wjGlobalRedColor()
    }
    
    
    // 点击事件
    @IBAction func wjIntroduceClickAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { 
            self.indicatorLineView.x = 0.0
            self.delegate?.wjIntroduceClick(sender)
        }
    }
    
    @IBAction func wjCommentClickAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5) { 
            self.indicatorLineView.x = SCREENW * 0.5 - 0.25
            self.delegate?.wjCommentClick(sender)
        }
    }
    
    class func wjChoiceBtnInitializer() -> wjChoiceBtn {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.first as! wjChoiceBtn
    }
    
}
