//
//  wjMeVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjMeVC: wjMainBaseVC {

    
    // 懒加载
    lazy var headerView : wjMeHeaderView = {
        let headerview = wjMeHeaderView()
        headerview.frame = CGRect(x: 0, y: 0, width: SCREENW, height: kwjMineHeaderImageHeight)
        headerview.noticeBtn.addTarget(self, action: #selector(self.noticeBtnAction), for: .touchUpInside)
        headerview.settingsBtn.addTarget(self, action: #selector(self.settingsBtnAction), for: .touchUpInside)
        headerview.headImageBtn.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        return headerview
    }()
    
    lazy var footerView : wjFooterView = {
        let footView = wjFooterView()
        footView.frame = CGRect(x: 0, y: 0, width: SCREENW, height: 200)
        footView.heartBtn.addTarget(self, action: #selector(self.loginAction), for: .touchUpInside)
        return footView
    }()
    
    
    
    // 生命周期
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false) // 隐藏导航栏
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wjSetUpUISettings()
        
    }
}


// UI界面的搭建
extension wjMeVC {
    func wjSetUpUISettings() {
        // 
        let tableview = UITableView()
        tableview.frame = view.bounds
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableHeaderView = headerView
        tableview.tableFooterView = footerView
        view.addSubview(tableview)
        
    }
}


// MARK:- UITableViewDataSource
extension wjMeVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserDefaults.standard.bool(forKey: isLogin) {
            return 20
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let detailBar = wjChoiceBtn.wjChoiceBtnInitializer()
        detailBar.introductionBtn.setTitle("喜欢的商品", for: .normal)
        detailBar.commentBtn.setTitle("喜欢的专题", for: .normal)
        return detailBar
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iden = "cells"
        var cell = tableView.dequeueReusableCell(withIdentifier: iden)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: iden)
        }
        cell?.textLabel?.text = "已经登录的了--" + String(indexPath.row)
        return cell!
    }
}

// MARK:- UITableViewDelegate
extension wjMeVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("123")
    }
}


// MARK:- scrollviewDelegate
extension wjMeVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            var tempFrame = headerView.backImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = kwjMineHeaderImageHeight - offsetY
            headerView.backImageView.frame = tempFrame
        }
        
    }
}

// 按钮的点击事件
extension wjMeVC {
    // 顶部的消息通知
    func noticeBtnAction() {
        
    }
    
    // 顶部的设置
    func settingsBtnAction() {
        let settingVC = wjSettingsVC()
        settingVC.title = "更多"
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    // 头像的点击和底部的登录按钮的点击
    func loginAction() {
        
    }
}
