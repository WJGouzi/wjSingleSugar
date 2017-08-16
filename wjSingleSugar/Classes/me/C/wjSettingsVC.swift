//
//  wjSettingsVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

let settingIden = "settingsCell"

class wjSettingsVC: wjMainBaseVC {

    var sectionSettings = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjSetUpUI()
        wjLoadPlistData()
    }

}

extension wjSettingsVC {
    func wjSetUpUI() {
        let tableview = UITableView(frame: view.bounds, style: .grouped)
//        tableview.frame = view.bounds
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.rowHeight = 44
        let nib = UINib(nibName: String(describing: wjSettingCell.self), bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: settingIden)
        view.addSubview(tableview)
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
