//
//  wjProductDetailVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit

class wjProductDetailVC: wjMainBaseVC {
    // 属性
    var model : wjProductModel?
    
    lazy var toolBarView : wjProductDetailToolBar = {
        let toolBar = Bundle.main.loadNibNamed(String(describing : wjProductDetailToolBar.self), owner: nil, options: nil)?.first as! wjProductDetailToolBar
        toolBar.delegate = self
        return toolBar
    }()
    
    
    lazy var contentScrollView : wjDetailScrollView = {
        let contentView = wjDetailScrollView()
        contentView.delegate = self
        contentView.showsHorizontalScrollIndicator = false
        return contentView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjNavigationSettings()
        wjDetailUISettings()
        wjLog(model?.url)
    }
}

// MARK:- 界面搭建
extension wjProductDetailVC {
    func wjNavigationSettings() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named : "GiftShare_icon_18x22_"), style: .plain, target: self, action: #selector(self.wjShareAction))
    }
    
    // 基本界面的搭建
    func wjDetailUISettings() {
        // 添加底部的toolBar
        view.addSubview(toolBarView)
        toolBarView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(view)
            make.height.equalTo(45)
        }
        
        view.addSubview(contentScrollView)
        contentScrollView.product = model
        contentScrollView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(view)
            make.bottom.equalTo(toolBarView.snp.top)
        }
        contentScrollView.contentSize = CGSize(width: SCREENW, height: SCREENH - 64 - 45 + kMargin + 520)
    }
}


// MARK:- 按钮的点击事件
extension wjProductDetailVC {
    // 分享按钮的点击事件
    func wjShareAction() {
        let shareSheetView = wjShareActionSheet.showShareSheet()
        shareSheetView.model = self.model
    }
}



var isLiked = false
extension wjProductDetailVC : wjProductDetailToolBarDelegate {
    func wjGotoTmallClickAction() {
        // 使用之前的detailContentVC
        let detailConteVC = wjDetailContentVC()
        detailConteVC.productItem = model
        detailConteVC.title = "商品详情"
        navigationController?.pushViewController(detailConteVC, animated: true)
    }
    
    func wjLikedBtnClickAction(_ btn: UIButton) {
        if !UserDefaults.standard.bool(forKey: isLogin) {
            // 登录
            let loginVC = wjLoginVC()
            loginVC.title = "登录"
            let nav = wjNavigationVC(rootViewController: loginVC)
            present(nav, animated: true, completion: nil)
        } else {
            btn.isSelected = !isLiked
            isLiked = !isLiked
        }
    }
}

extension wjProductDetailVC : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        if offsetY >= 465 {
            offsetY = CGFloat(465)
            scrollView.contentOffset = CGPoint(x: 0, y: offsetY)
        }
    }
}


