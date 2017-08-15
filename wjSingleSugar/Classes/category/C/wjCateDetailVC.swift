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

    
    var model : wjCateDetailModel? {
        didSet {
            
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wjTableViewSetup()
        
    }
}


// 界面的搭建
extension wjCateDetailVC {
    func wjTableViewSetup() {
        tableView.frame = view.bounds
        let nib = UINib(nibName: String(describing: wjEachPageCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cateDetailCellIden)
    }
}


// MARK: - Table view data source
extension wjCateDetailVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 20
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cateDetailCellIden) as! wjEachPageCell
//        cell.item = 
        return cell
    }
    
}
