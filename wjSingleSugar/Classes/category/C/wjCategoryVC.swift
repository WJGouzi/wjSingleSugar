//
//  wjCategoryVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit

class wjCategoryVC: wjMainBaseVC {

    
    // 懒加载
    lazy var categoryScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = wjGlobalColor()
        scrollView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: SCREENH)
//        scrollView.contentSize = CGSize(width: SCREENW, height: 900)
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    
    lazy var wjTopScrollView : wjCateTopScrollview = {
        let topView = wjCateTopScrollview()
        topView.delegate = self
        return topView
    }()
    
    
    lazy var wjStyleClassView : wjStyleAndClassView = {
        let styleClassView = wjStyleAndClassView()
        styleClassView.backgroundColor = wjGlobalColor()
        return styleClassView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjNavigationSettings()
        
        // 分类页面->顶部的scrollview
        wjNetworkTool.shareNetwork.wjLoadCategoryTopCollection(limit: 6) { (collectionModels) in
            self.wjTopScrollView.cateTopModels = collectionModels
        }
        wjSetUpUI()
    }
}


// 界面搭建
extension wjCategoryVC {
    
    func wjNavigationSettings() {
        self.title = "分类"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named : "Feed_SearchBtn_18x18_"), style: .plain, target: self, action: #selector(self.wjSearchAction))
    }
    
    func wjSetUpUI() {
        let topViewHeight = CGFloat(135)
        view.addSubview(categoryScrollView)
        wjTopScrollView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: topViewHeight)
        categoryScrollView.addSubview(wjTopScrollView)
        wjStyleClassView.frame = CGRect(x: 0, y: wjTopScrollView.frame.maxY + kMargin, width: SCREENW, height: SCREENH - 160)
        wjStyleClassView.delegate = self
        categoryScrollView.addSubview(wjStyleClassView)
        categoryScrollView.contentSize = CGSize(width: SCREENW, height: wjStyleClassView.frame.maxY)
    }
}


// 按钮的一些点击操作
extension wjCategoryVC : wjCategoryDelegate, wjStyleAndClassDelegate {
    func wjSearchAction() {
        
    }
    
    // 顶部加载更多按钮的
    func wjLoadMoreBtnAction() {
//        print("123")
        let seeAllVC = wjSeeAllVC()
        seeAllVC.title = "查看全部"
        navigationController?.pushViewController(seeAllVC, animated: true)
    }
    
    // 图片的点击事件
    func wjImageViewDidSelected(_ model: wjCateTopModel) {
        // 点击进入到cell详情界面去
        let cateDetailVC = wjCateDetailVC()
        cateDetailVC.title = model.title!
        cateDetailVC.id = model.id!
        cateDetailVC.type = "专题合集"
        navigationController?.pushViewController(cateDetailVC, animated: true)
    }
    
    func wjStyleAndClassViewButtonDidClicked(button: UIButton) {
        let collectionDetailVC = wjCateDetailVC()
        collectionDetailVC.title = button.titleLabel?.text!
        collectionDetailVC.id = button.tag
        collectionDetailVC.type = "风格品类"
        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }
    
}
