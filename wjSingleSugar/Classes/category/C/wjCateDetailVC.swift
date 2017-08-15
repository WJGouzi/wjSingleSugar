//
//  wjCateDetailVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/15.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

let cateDetailCellIden = "cateDetailCell"

class wjCateDetailVC: UITableViewController {

    var id = Int()
    
    var models = [wjCateDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        wjTableViewSetup()
        wjLoadDetailData()
    }
}


// 界面的搭建
extension wjCateDetailVC {
    func wjTableViewSetup() {
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
        let nib = UINib(nibName: String(describing : wjEachPageCell.self) , bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cateDetailCellIden)
    }
}


// 数据加载
extension wjCateDetailVC {
    func wjLoadDetailData() {
        wjNetworkTool.shareNetwork.wjLoadEachCategoryDetailData(id: id) { (models) in
            self.models = models
            self.tableView.reloadData()
        }
    }
}


// MARK: - Table view data source
extension wjCateDetailVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cateDetailCellIden) as! wjEachPageCell
        cell.selectionStyle = .none
        cell.detailModel = models[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension wjCateDetailVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = wjDetailContentVC()
        detailView.title = "攻略详情"
        detailView.detailModel = models[indexPath.row]
        navigationController?.pushViewController(detailView, animated: true)
    }
}

extension wjCateDetailVC : wjEachTopicCellDelegate {
    func wjLikedBtnClickedAction(likedBtn: UIButton) {
        
    }
}

