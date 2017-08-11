//
//  wjNavigationVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjNavigationVC: UINavigationController {
    
    internal override class func initialize() {
        super.initialize()
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = wjGlobalRedColor() // 背景颜色
        navBar.tintColor = UIColor.white // 其他的颜色
        navBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)]
    }
    
    
    /// 统一所有控制器导航栏左上角的返回按钮
    /// 让所有push进来的控制器，它的导航栏左上角的内容都一样
    /// 能拦截所有的push操作
    ///
    /// - Parameters:
    ///   - viewController: 需要压栈的控制器
    ///   - animated: 是否动画
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named : "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(wjNavigationPopClick))
        }
        super.pushViewController(viewController, animated: true)
        
    }
    
    func wjNavigationPopClick() {
        
        popViewController(animated: true)
    }
    
}
