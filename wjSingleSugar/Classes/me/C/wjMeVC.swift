//
//  wjMeVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjMeVC: wjMainBaseVC {

    var tableView : UITableView?
    var headBtn = UIButton()
    
    // 懒加载
    lazy var headerView : wjMeHeaderView = {
        let headerview = wjMeHeaderView()
        headerview.frame = CGRect(x: 0, y: 0, width: SCREENW, height: kwjMineHeaderImageHeight)
        headerview.noticeBtn.addTarget(self, action: #selector(self.noticeBtnAction), for: .touchUpInside)
        headerview.settingsBtn.addTarget(self, action: #selector(self.settingsBtnAction), for: .touchUpInside)
        headerview.headImageBtn.addTarget(self, action: #selector(self.wjHeadImageBtnClickAction), for: .touchUpInside)
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
        if !UserDefaults.standard.bool(forKey: isLogin) {
            tableView?.tableFooterView = footerView
        } else {
            tableView?.tableFooterView = UIView()
        }
        self.tableView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wjSetUpUISettings()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
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
        if !UserDefaults.standard.bool(forKey: isLogin) {
            tableview.tableFooterView = footerView
        } else {
            tableview.tableFooterView = UIView()
        }
        view.addSubview(tableview)
        self.tableView = tableview
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
        if UserDefaults.standard.bool(forKey: isLogin) {
            // 登录了就有，没有登录就没
            return 44
        } else {
            return 0
        }
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
        cell?.selectionStyle = .none
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
        print(offsetY)
        if offsetY < 0 {
            var tempFrame = headerView.backImageView.frame
            tempFrame.origin.y = offsetY
            tempFrame.size.height = kwjMineHeaderImageHeight - offsetY
            headerView.backImageView.frame = tempFrame
        }
//        else if offsetY >= 170 {
//            navigationController?.setNavigationBarHidden(false, animated: false)
//            self.title = "我的"
//        } else {
//            navigationController?.setNavigationBarHidden(true, animated: false)
//        }
        
    }
}


// 按钮的点击事件
extension wjMeVC {
    // 顶部的消息通知
    func noticeBtnAction() {
        let noticeVC = wjNoticeVC()
        noticeVC.title = "通知"
        navigationController?.pushViewController(noticeVC, animated: true)
    }
    
    // 顶部的设置
    func settingsBtnAction() {
        let settingVC = wjSettingsVC()
        settingVC.title = "更多"
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    
    
    // 头像的点击和修改头像按钮的点击
    func wjHeadImageBtnClickAction(_ btn : UIButton) {
        if UserDefaults.standard.bool(forKey: isLogin) {
            // 登录就修改头像
            print(btn.frame)
            wjSelectedHeadViewImage(btn)
        } else {
            // 没有登录就就进行登录
            loginAction()
        }
    }
    
    
    // footerView上的点击事件
    func loginAction() {
        let loginVC = wjLoginVC()
        loginVC.title = "登录"
        let nav = wjNavigationVC(rootViewController: loginVC)
        present(nav, animated: true, completion: nil)
    }
    
    // 修改头像
    func wjSelectedHeadViewImage(_ btn : UIButton) {
        // 相册中选择
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        headBtn = btn
    }
}


extension wjMeVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let selectedImage = info["UIImagePickerControllerEditedImage"] as! UIImage
        // 图片进行切圆角处理
        UIGraphicsBeginImageContext(selectedImage.size);
        let ctx = UIGraphicsGetCurrentContext();
        let rect = CGRect(x: 0, y: 0, width: selectedImage.size.width, height: selectedImage.size.height)
        ctx!.addEllipse(in: rect);
        ctx!.clip();
        selectedImage.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        let imageData = UIImagePNGRepresentation(image!)
        UserDefaults.standard.set(imageData, forKey: userHeadImage)
        headBtn.setImage(image, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
}

