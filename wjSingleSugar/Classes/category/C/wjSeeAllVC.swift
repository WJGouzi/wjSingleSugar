//
//  wjSeeAllVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

let cellIden = "seeAllCell"


class wjSeeAllVC: UITableViewController {

    var models = [wjCateTopModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wjSetUpUI()
        wjSeeAllDetailData()
    }

}


// MARK:- UI界面的搭建以及数据请求
extension wjSeeAllVC {
    func wjSetUpUI() {
        tableView.separatorStyle = .none
        tableView.rowHeight = 160
        let nib = UINib(nibName: String(describing: wjSeeAllCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIden)
    }
    
    func wjSeeAllDetailData() {
        wjNetworkTool.shareNetwork.wjLoadCategoryTopCollection(limit: 20) { (models) in
            self.models = models
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - Table view data source
extension wjSeeAllVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIden) as! wjSeeAllCell
        cell.model = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}


// MARK: - Table view data delegate
extension wjSeeAllVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVc = wjCateDetailVC()
        let model = models[indexPath.row]
        detailVc.title = model.title
        detailVc.id = model.id!
        detailVc.type = "专题合集"
        navigationController?.pushViewController(detailVc, animated: true)
    }
}
