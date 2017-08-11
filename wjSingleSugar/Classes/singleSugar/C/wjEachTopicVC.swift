//
//  wjEachTopicVC.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

let iden = "wjEachPageCell"


class wjEachTopicVC: UITableViewController {
    
    // 属性
    var items = [wjEachTopicModel]()
    var type = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = wjGlobalColor()
        // 添加控件
        wjAddSubTableView()
        // 刷新控件
        refreshControl?.addTarget(self, action: #selector(self.wjLoadEachPageItemData), for: .valueChanged)
        wjLoadEachPageItemData()
    }
}


// MARK:- 加载数据
extension wjEachTopicVC {

    func wjLoadEachPageItemData() {
        weak var weakSelf = self
        wjNetworkTool.shareNetwork.wjLoadHomePageEachLabelData(id: type) { (items) in
            weakSelf?.items = items
            weakSelf?.tableView.reloadData()
//            weakSelf?.refreshControl?.endRefreshing()
        }
    }
}


// MARK:- 添加控件
extension wjEachTopicVC {

//    func wjAddSubTableView() {
//        tableView.rowHeight = 160
//        tableView.separatorStyle = .none
//        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewH + kTitlesViewY, 0, tabBarController!.tabBar.height, 0)
//        tableView.scrollIndicatorInsets = tableView.contentInset
//        let nib = UINib(nibName: String(describing : wjEachPageCell.self) , bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: iden)
//    }
}

