//
//  wjSettingsVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SVProgressHUD


let settingIden = "settingsCell"

class wjSettingsVC: wjMainBaseVC {

    var sectionSettings = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjNavigationSettings()
        wjSetUpUI()
        wjLoadPlistData()
    }
}

// 界面的搭建
extension wjSettingsVC {
    
    func wjNavigationSettings() {
        var name = String()
        if UserDefaults.standard.bool(forKey: isLogin) {
            name = "注销"
        } else {
            name = "登录"
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: name, style: .plain, target: self, action: #selector(self.logOutAndInAction))
    }
    
    func wjSetUpUI() {
        let tableview = UITableView(frame: view.bounds, style: .grouped)
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.rowHeight = 44
        let nib = UINib(nibName: String(describing: wjSettingCell.self), bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: settingIden)
        view.addSubview(tableview)
    }
    
    // 登录登出
    func logOutAndInAction() {
        // 首先将本地存储的相关的信息注销掉
        if UserDefaults.standard.bool(forKey: isLogin) {
            UserDefaults.standard.set(nil, forKey: wjUserTelephone)
            UserDefaults.standard.set(nil, forKey: wjPassword)
            UserDefaults.standard.set(false, forKey: isLogin)
            // 提示
            SVProgressHUD.showInfo(withStatus: "用户已经注销成功")
            navigationItem.rightBarButtonItem?.title = "登录"
        } else {
            navigationItem.rightBarButtonItem?.title = "注销"
            let loginVC = wjLoginVC()
            loginVC.title = "登录"
            let nav = wjNavigationVC(rootViewController: loginVC)
            present(nav, animated: true, completion: nil)
        }
    }
    
}


// MARK:- 从plist中读取数据
extension wjSettingsVC {
    func wjLoadPlistData() {
        let path = Bundle.main.path(forResource: "SettingCell", ofType: "plist")
        let arrays = NSArray(contentsOfFile: path!)
        for item in arrays! {
            let itemDict = item as! NSArray
            var sections = [AnyObject]()
            for sectionDict in itemDict {
                let settingRow = wjSettingModel(dict: sectionDict as! [String : AnyObject])
                sections.append(settingRow)
            }
            sectionSettings.append(sections as AnyObject)
        }
    }
}


// MARK: - Table view data source
extension wjSettingsVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionSettings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionSettings[section] as! [wjSettingModel]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: settingIden) as! wjSettingCell
        cell.settingModel = (sectionSettings[indexPath.section] as! [wjSettingModel])[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }

}
