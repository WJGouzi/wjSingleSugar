//
//  wjDetailBottomView.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/15.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit

let commentCellIden = "CommentCell"

class wjDetailBottomView: UIView {

    // 属性
    var commentModels = [wjCommentModel]()
    
    // setter方法
    var item : wjProductModel? {
        didSet {
            // 加载web数据
            weak var weakSelf = self
            wjNetworkTool.shareNetwork.wjLoadEachProductItemIntroduceData(id: item!.id!) { (item) in
                // 设置评论按钮的文字
                weakSelf!.choiceBtn.commentBtn.setTitle("评论(\(item.comments_count!))", for: .normal)
                // 加载webview
                weakSelf!.webView.loadHTMLString(item.detail_html!, baseURL: nil)
            }
            
            // 加载评论的数据
            wjNetworkTool.shareNetwork.wjLoadEachProductComments(id: item!.id!) { (comments) in
                weakSelf?.commentModels = comments
                weakSelf?.commentTableView.reloadData()
            }
        }
    }
    
    // 懒加载
    lazy var choiceBtn : wjChoiceBtn = {
        let choiceBtn = wjChoiceBtn.wjChoiceBtnInitializer()
        choiceBtn.delegate = self
        return choiceBtn
    }()

    lazy var webView : UIWebView = {
        let webView = UIWebView()
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        webView.delegate = self
        return webView
    }()
    
    lazy var commentTableView : UITableView = {
        let commentView = UITableView()
        commentView.isHidden = true
        commentView.dataSource = self
        commentView.rowHeight = 64
        commentView.separatorStyle = .none
        let nib = UINib(nibName: String(describing: wjCommentCell.self), bundle: nil)
        commentView.register(nib, forCellReuseIdentifier: commentCellIden)
        return commentView
    }()
    
    // 构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        wjSetUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// UI界面的搭建
extension wjDetailBottomView {
    func wjSetUpUI() {
        
        addSubview(choiceBtn)
        addSubview(webView)
        addSubview(commentTableView)
        // 约束
        choiceBtn.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(44)
        }
        webView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.top.equalTo(choiceBtn.snp.bottom)
        }
        commentTableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.top.equalTo(choiceBtn.snp.bottom)
        }
    }
}

// MARK:- 代理相关
// MARK:- wjChoiceBtnClickDelegate
extension wjDetailBottomView : wjChoiceBtnClickDelegate {
    func wjIntroduceClick(_ btn: UIButton) {
        UIView.animate(withDuration: 0.25) {
            self.commentTableView.isHidden = true
            self.commentTableView.alpha = 0.0
        }
        UIView.animate(withDuration: 0.25) { 
            self.webView.isHidden = false
            self.webView.alpha = 1.0
        }
    }
    
    func wjCommentClick(_ btn: UIButton) {
        UIView.animate(withDuration: 0.25) { 
            self.webView.isHidden = true
            self.webView.alpha = 0.0
        }
        UIView.animate(withDuration: 0.25) { 
            self.commentTableView.isHidden = false
            self.commentTableView.alpha = 1.0
        }
    }
}

extension wjDetailBottomView : UIWebViewDelegate {
    private func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

extension wjDetailBottomView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellIden) as! wjCommentCell
        cell.commentModel = commentModels[indexPath.row]
        return cell
    }
    
}


