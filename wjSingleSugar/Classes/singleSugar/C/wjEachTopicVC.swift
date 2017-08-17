//
//  wjEachTopic1VC.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/13.
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
        refreshControl?.addTarget(self, action: #selector(self.loadHomeData), for: .valueChanged)
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
        }
    }
    
    func loadHomeData() {
        // 获取首页数据
        weak var weakSelf = self
        wjNetworkTool.shareNetwork.wjLoadHomePageEachLabelData(id: type) { (items) in
            weakSelf!.items = items
            weakSelf!.tableView!.reloadData()
            weakSelf!.refreshControl?.endRefreshing()
        }
    }
}




// MARK:- 添加控件
extension wjEachTopicVC {
    
    func wjAddSubTableView() {
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY + kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: String(describing : wjEachPageCell.self) , bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: iden)
    }
}



// MARK: - Table view data source
extension wjEachTopicVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: iden) as! wjEachPageCell
        cell.item = items[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.delegate = self
        return cell
    }
}

var isLikeClicked = false
// MARK:- wjEachTopicCellDelegate
extension wjEachTopicVC : wjEachTopicCellDelegate {
    
    func wjLikedBtnClickedAction(likedBtn: UIButton) {
        /*
         注意:
            这里的bug存点的点为:
            1.本控制器的每个cell在点击后的，在点击本控制器的cell的喜欢按钮后，之前的cell的状态会一直保留着的
            2.在不同的控制器之间进行切换的时候，cell的点击状态也依然是被保存了的。
         解决办法:
            要不就把每个控制器的cell进绑定，然后在点击的时候进行判断。？
         */
        
        var count = Int()
        // 获取到按钮上的喜欢的数量
        if let likedText = likedBtn.titleLabel?.text {
            let likeTextArray = likedText.components(separatedBy: " ")
            count = Int(likeTextArray[1])!
        }
        if !UserDefaults.standard.bool(forKey: isLogin) {
            let loginVC = wjLoginVC()
            loginVC.title = "登录"
            let nav = wjNavigationVC(rootViewController: loginVC)
            present(nav, animated: true, completion: nil)
        } else {
            if isLikeClicked == false {
                likedBtn.setImage(UIImage(named : "content-details_like_selected_16x16_"), for: .normal)
                likedBtn.setTitle(" " +  String(count + 1) + " ", for: .normal)
            } else {
                likedBtn.setImage(UIImage(named : "Feed_FavoriteIcon_17x17_"), for: .normal)
                likedBtn.setTitle(" " +  String(count - 1) + " ", for: .normal)
            }
            isLikeClicked = !isLikeClicked
        }
    }
}


// MARK:- tableViewDelegate
extension wjEachTopicVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = wjDetailContentVC()
        detailView.title = "攻略详情"
        detailView.item = items[indexPath.row]
        navigationController?.pushViewController(detailView, animated: true)
    }
}


