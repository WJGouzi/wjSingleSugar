//
//  wjTabBarVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tabBar = UITabBar.appearance()
        tabBar.tintColor = wjColor(r: 245, g: 90, b: 93, a: 1.0)
        wjAddChildControllers()
    }
    
    fileprivate func wjAddChildControllers() {
        wjAddChildWithNameAndImage(childVC:UIViewController(), title: "单糖", imageName: "TabBar_home_23x23_")
        wjAddChildWithNameAndImage(childVC:UIViewController(), title: "单品", imageName: "TabBar_gift_23x23_")
        wjAddChildWithNameAndImage(childVC:UIViewController(), title: "分类", imageName: "TabBar_category_23x23_")
        wjAddChildWithNameAndImage(childVC:UIViewController(), title: "我的", imageName: "TabBar_me_boy_23x23_")
    }
    
    fileprivate func wjAddChildWithNameAndImage(childVC childViewCotroller : UIViewController, title : String, imageName : String) {
        childViewCotroller.tabBarItem.title = title
        childViewCotroller.tabBarItem.image = UIImage(named: imageName)
        childViewCotroller.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        let nav = wjNavigationVC(rootViewController: childViewCotroller)
        addChildViewController(nav)
    }
    

}
