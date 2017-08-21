//
//  wjShareActionSheet.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/18.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class wjShareActionSheet: UIView {
    
    var model : wjProductModel?
    
    
    // 相当于是类方法-> 没办法只有弄个返回值。
    class func showShareSheet() -> wjShareActionSheet {
        let sheetView = wjShareActionSheet()
        sheetView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        sheetView.frame = UIScreen.main.bounds
        let window = UIApplication.shared.keyWindow
        window?.addSubview(sheetView)
        return sheetView
    }
    
    // 创建这个分享页面的背景
    lazy var backgroundView : UIView = {
        let backV = UIView()
        backV.frame = CGRect(x: 0, y: SCREENH, width: SCREENW, height: 300)
        return backV
    }()
    
    // 下面部分的取消按钮
    lazy var cancelBtn : UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.setTitle("取  消", for: .normal)
        cancelBtn.setTitleColor(wjGlobalRedColor(), for: .normal)
        cancelBtn.backgroundColor = UIColor.white
        cancelBtn.layer.masksToBounds = true
        cancelBtn.layer.cornerRadius = kCornerRadius
        cancelBtn.addTarget(self, action: #selector(self.cancelAction), for: .touchUpInside)
        return cancelBtn
    }()
    
    lazy var topShareView : UIView = {
        let topView = UIView()
        topView.backgroundColor = UIColor.white
        topView.layer.masksToBounds = true
        topView.layer.cornerRadius = kCornerRadius
        return topView
    }()
    
    lazy var titleLabel : UILabel = {
        let titleL = UILabel()
        titleL.text = "分享到"
        titleL.textColor = wjGlobalRedColor()
        titleL.textAlignment = .center
        titleL.font = UIFont.systemFont(ofSize: 17.0)
        return titleL
    }()
    
    lazy var shareBtnView : UIView = {
        let shareBtnView = UIView()
        return shareBtnView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        wjSetUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animate(withDuration: kAnimationDuration) {
            self.backgroundView.y = SCREENH - self.backgroundView.height
        }
    }
    
}

// MARK:- 建立UI界面
extension wjShareActionSheet {
    func wjSetUpUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(backgroundView).offset(-kMargin)
            make.left.equalTo(backgroundView).offset(kMargin)
            make.height.equalTo(44)
        }
        backgroundView.addSubview(topShareView)
        topShareView.snp.makeConstraints { (make) in
            make.bottom.equalTo(cancelBtn.snp.top).offset(-kMargin)
            make.left.right.equalTo(cancelBtn)
            make.top.equalTo(backgroundView.snp.top)
        }
        topShareView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(topShareView)
            make.height.equalTo(44)
        }
        topShareView.addSubview(shareBtnView)
        shareBtnView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.right.bottom.equalTo(topShareView)
        }
        
        let images : [String] = ["Share_WeChatTimelineIcon_70x70_", "Share_WeChatSessionIcon_70x70_", "Share_WeiboIcon_70x70_", "Share_QzoneIcon_70x70_", "Share_QQIcon_70x70_", "Share_CopyLinkIcon_70x70_"]
        let titles : [String] = ["朋友圈", "微信好友", "微博", "QQ 空间", "QQ 好友", "复制链接"]
        let maxCols = 3
        let btnW : CGFloat = 70;
        let btnH : CGFloat = btnW + 30
        let btnStartX: CGFloat = 20
        let xMargin: CGFloat = (SCREENW - 20 - 2 * btnStartX - CGFloat(maxCols) * btnW) / CGFloat(maxCols - 1)
        for idx in 0..<images.count {
            let btn = wjCollectionBtn()
            btn.tag = idx
            btn.setTitle(titles[idx], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setImage(UIImage(named : images[idx]), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.width = btnW
            btn.height = btnH
            btn.addTarget(self, action: #selector(self.shareBtnAction), for: .touchUpInside)
            let row = Int(idx / maxCols)
            let col = Int(idx % maxCols)
            let btnX : CGFloat = CGFloat(col) * (xMargin + btnW) + btnStartX
            let btnMaxY = CGFloat(row) * btnH
            let btnY = btnMaxY
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            shareBtnView.addSubview(btn)
        }
        
    }
}


// MARK:- 点击事件
extension wjShareActionSheet {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: kAnimationDuration, animations: { 
            self.backgroundView.y = SCREENH
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    func cancelAction() {
        UIView.animate(withDuration: kAnimationDuration, animations: {
            self.backgroundView.y = SCREENH
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    func shareBtnAction(_ btn : UIButton) {
        wjLog(btn.tag)
        
        if let btnType = wjShareButtonType(rawValue : btn.tag) {
            switch btnType {
            case .weChatTimeline:
                break
            case .weChatSession:
                break
            case .weibo:
                cancelAction()
                wjShareToWebo(model!)
                break
            case .qZone:
                break
            case .qqFriends:
                break
            case .copyLink:
                wjCopyToClipBoard(model!.url!)
                break
            }
        }
    }
    
    
}


// MARK:- 分享按钮的各种点击事件
extension wjShareActionSheet {
    
    // 微博分享
    func wjShareToWebo(_ model : wjProductModel) {
        let authorizeRequest = WBAuthorizeRequest.request() as? WBAuthorizeRequest
        authorizeRequest?.redirectURI = kRedirectURI
        authorizeRequest?.scope = "all"
        let myDelegate = UIApplication.shared.delegate as! AppDelegate
        let messageObject = WBMessageObject.message() as! WBMessageObject
        messageObject.text = "这是测试的text文字"
        let request = WBSendMessageToWeiboRequest.request(withMessage: messageObject, authInfo: authorizeRequest, access_token: myDelegate.wbtoken) as! WBSendMessageToWeiboRequest
        
        request.userInfo = ["SSO_Key":"SSO_Value"]
        WeiboSDK.send(authorizeRequest)
    }
    
    
    
    // 复制链接的点击事件
    func wjCopyToClipBoard(_ cooyString : String) {
        let pastedBoard = UIPasteboard.general
        pastedBoard.string = cooyString
        if #available(iOS 10.0, *) {
            if pastedBoard.hasURLs {
                let label = UILabel()
                label.alpha = 0
                label.text = "复制成功"
                label.backgroundColor = wjGlobalRedColor()
                label.sizeToFit()
                label.font = UIFont.systemFont(ofSize: 17)
                label.textAlignment = .center
                label.textColor = UIColor.white
                label.layer.masksToBounds = true
                label.layer.cornerRadius = kCornerRadius
                shareBtnView.addSubview(label)
                label.snp.makeConstraints({ (make) in
                    make.center.equalTo(topShareView)
                    make.width.equalTo(90)
                    make.height.equalTo(44)
                })
                UIView.animate(withDuration: 5 * kAnimationDuration, animations: {
                    label.alpha = 1
                }, completion: { (_) in
                    UIView.animate(withDuration: 5 * kAnimationDuration, animations: {
                        label.alpha = 0
                    })
                })
            }
        }
    }

}


