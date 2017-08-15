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
        scrollView.frame = CGRect(x: 0, y: 64, width: SCREENW, height: SCREENH - 64)
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    
    lazy var wjTopScrollView : wjCateTopScrollview = {
        let topView = wjCateTopScrollview()
        topView.delegate = self
        return topView
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
        view.addSubview(categoryScrollView)
        view.addSubview(wjTopScrollView)
        
        // 约束
        wjTopScrollView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(categoryScrollView)
            make.height.equalTo(135)
        }
        
    }
}


// 按钮的一些点击操作
extension wjCategoryVC : wjCategoryDelegate {
    func wjSearchAction() {
        
    }
    
    // 顶部加载更多按钮的
    func wjLoadMoreBtnAction() {
        print("123")
    }
    
    // 图片的点击事件
    func wjImageViewDidSelected(_ model: wjCateTopModel) {
        // 点击进入到cell详情界面去
        let cateDetailVC = wjCateDetailVC()
        cateDetailVC.title = model.title!
        cateDetailVC.id = model.id!
        navigationController?.pushViewController(cateDetailVC, animated: true)
    }
}
