//
//  wjNoticeVC.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit

class wjNoticeVC: UITableViewController {

    
    lazy var backView : UIView = {
        let backV = UIView()
        backV.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return backV
    }()
    
    
    lazy var imageView : UIImageView = {
        // 创建一些信息label及imageView
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        return imageView
    }()
    
    lazy var label : UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = wjGlobalRedColor()
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 16.0)
        return textLabel
    }()
    
    lazy var btn : UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(wjGlobalRedColor(), for: .normal)
        btn.addTarget(self, action: #selector(self.sureBtnAction), for: .touchUpInside)
        btn.titleLabel?.sizeToFit()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func sureBtnAction() {
        backView.removeFromSuperview()
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
        cell?.selectionStyle = .none
        return cell!
    }
    
}


// MARK: - Table view delegate
extension wjNoticeVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        backView.frame = view.frame
        let window = UIApplication.shared.keyWindow
        window?.addSubview(backView)

        backView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 230, height: 450))
            make.center.equalTo(backView.snp.center)
        }
        backView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(kMargin)
            make.height.equalTo(25)
            make.left.right.equalTo(backView)
        }
        let cell = tableView.cellForRow(at: indexPath)
        label.text = "选中的的是 : " + (cell?.textLabel?.text)! + (cell?.detailTextLabel?.text)!
        backView.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.right.equalTo(backView).offset(-5)
            make.top.equalTo(backView).offset(75)
        }
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.repeatCount = 1
        animation.duration = 0.2
        animation.autoreverses = false
        backView.layer.add(animation, forKey: nil)
    }
}
