//
//  wjSingleSugarVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjSingleSugarVC: wjMainBaseVC {

    // 属性
    var channels = [wjChannelModel]()
    // 标签
    weak var titlesView = UIView()
    // 底部的指示器
    weak var indicator = UIView()
    weak var contentView = UIScrollView()
    // 当前选中的按钮
    weak var selectedBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wjNavigationSettings()
        wjSingleSugarTopBarDataRequest()
    }
}


// MARK:- 导航栏的设置
extension wjSingleSugarVC {
    func wjNavigationSettings() {
        self.title = "单糖"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named : "Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(self.wjSingleSugarSearchAction))
    }
    
    func wjSingleSugarSearchAction() {
        
    }
}


// MARK:- 数据加载
extension wjSingleSugarVC {
    // 获取顶部的标签的数据
    func wjSingleSugarTopBarDataRequest() {
        weak var weakSelf = self
        wjNetworkTool.shareNetwork.wjLoadHomePageTopData { (wjChannels) in
            for channel in wjChannels {
                let vc = wjEachTopicVC()
                vc.title = channel.name!
                vc.type = channel.id!
                weakSelf?.addChildViewController(vc)
            }
            weakSelf?.wjLoadTopBarView()
            weakSelf?.wjShowEachLabelContent()
        }
    }
}


// MARK:- 加载视图
extension wjSingleSugarVC {
    // 初始化自控制器
    func setupChildViewControllers() {
        for channel in channels {
            let vc = wjEachTopicVC()
            vc.title = channel.name
            addChildViewController(vc)
        }
    }
    
    // 加载顶部的标签
    func wjLoadTopBarView() {
        // 背景视图
        let bgView = UIView()
        bgView.frame = CGRect(x: 0, y: kTitlesViewY, width: SCREENW, height: kTitlesViewH)
        view.addSubview(bgView)
        
        // 标签的view
        let titlesView = UIView()
        titlesView.frame = CGRect(x: 0, y: 0, width: SCREENW - kTitlesViewH, height: kTitlesViewH)
        titlesView.backgroundColor = wjGlobalColor()
        bgView.addSubview(titlesView)
        self.titlesView = titlesView
        
        // 指示器
        let indicator = UIView()
        indicator.backgroundColor = wjGlobalRedColor()
        indicator.y = kTitlesViewH - kIndicatorViewH
        indicator.height = kIndicatorViewH
        indicator.tag = -1 // 先给个不用的值
        self.indicator = indicator
        
        // 箭头
        let arrowBtn = UIButton()
        arrowBtn.frame = CGRect(x: SCREENW - kTitlesViewH, y: 0, width: kTitlesViewH, height: kTitlesViewH)
        arrowBtn.setImage(UIImage(named: "arrow_index_down_8x4_"), for: .normal)
        arrowBtn.addTarget(self, action: #selector(self.arrowAction(_ :)), for: .touchUpInside)
        arrowBtn.backgroundColor = wjGlobalColor()
        bgView.addSubview(arrowBtn)
        
        // 各个标签创建
        let labelCount = childViewControllers.count
        let labelW = titlesView.width / CGFloat(labelCount)
        let labelH = titlesView.height
        for idx in 0..<labelCount {
            let btn = UIButton()
            btn.width = labelW
            btn.height = labelH
            btn.x = labelW * CGFloat(idx)
            btn.tag = idx
            let vc = childViewControllers[idx]
            btn.titleLabel!.font = UIFont.systemFont(ofSize: 14)
            btn.setTitle(vc.title!, for: .normal)
            btn.setTitleColor(UIColor.gray, for: .normal)
            btn.setTitleColor(wjGlobalRedColor(), for: .disabled)
            btn.addTarget(self, action: #selector(self.changeTitleClickAction(_ :)), for: .touchUpInside)
            titlesView.addSubview(btn)
            // 默认第一个是被点击的。
            if idx == 0 {
                btn.isEnabled = false
                selectedBtn = btn
                btn.titleLabel?.sizeToFit()
                indicator.width = btn.titleLabel!.width
                indicator.centerX = btn.centerX
                
            }
        }
        // 底部添加指示器
        titlesView.addSubview(indicator)
    }
    
    
    // 设置底部的scrollView->展示的就是各个控制器
    func wjShowEachLabelContent() {
        // 不要自己调整位置
        automaticallyAdjustsScrollViewInsets = false
        let contentView = UIScrollView()
        contentView.frame = view.bounds
        contentView.contentSize = CGSize(width: CGFloat(childViewControllers.count) * SCREENW, height: 0)
        contentView.isPagingEnabled = true
        view.insertSubview(contentView, at: 0)
        contentView.delegate = self
        self.contentView = contentView
        scrollViewDidEndScrollingAnimation(contentView)
    }
}


// MARK:- 各种按钮的点击事件
extension wjSingleSugarVC {
    // 箭头的点击事件
    func arrowAction(_ btn : UIButton) {
    
        UIView.animate(withDuration: kAnimationDuration) { 
            btn.imageView?.transform = btn.imageView!.transform.rotated(by: CGFloat(Double.pi))
        }
        
    }
    
    // 每个标签的点击事件
    func changeTitleClickAction(_ button : UIButton) {
        // 修改器点击状态
        selectedBtn?.isEnabled = true
        button.isEnabled = false
        selectedBtn = button
        // 让指示器进行切换
        UIView.animate(withDuration: kAnimationDuration) { 
            self.indicator!.width = button.titleLabel!.width
            self.indicator!.centerX = button.centerX
        }
        
        // 切换子控制器
        var offset = contentView!.contentOffset
        offset.x = CGFloat(button.tag) * contentView!.width
        contentView?.setContentOffset(offset, animated: true)
    }
}



extension wjSingleSugarVC : UIScrollViewDelegate {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        // 切换页面
        let idx = Int(scrollView.contentOffset.x / scrollView.width)
        let vc = childViewControllers[idx]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        scrollView.addSubview(vc.view)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        // 标签的点击事件
        let btn = titlesView?.subviews[index] as! UIButton
        changeTitleClickAction(btn)
    }
}







