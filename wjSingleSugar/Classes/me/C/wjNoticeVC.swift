//
//  wjNoticeVC.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjNoticeVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


// MARK: - Table view data source
extension wjNoticeVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIden = "noticeCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIden)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIden)
        }
        cell?.textLabel?.text = "消息"
        cell?.detailTextLabel?.text = "详细消息:" + String(indexPath.row)
        return cell!
    }
    
}
