//
//  wjDetailContentVC.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/13.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import SVProgressHUD

class wjDetailContentVC: wjMainBaseVC {

    var item : wjEachTopicModel?
    var detailModel : wjCateDetailModel?
    
    var productItem : wjProductModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjNavigationSettings()
        wjSetWebView()
    }
}


extension wjDetailContentVC {
    func wjSetWebView() {
        let webView = UIWebView()
        webView.frame = view.bounds
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        var url = String()
        let navArray = navigationController?.viewControllers
        let vc = navArray?[(navArray?.count)! - 2]
        if (vc is wjProductDetailVC){
            url = productItem!.purchase_url!
        } else if (vc is wjCateDetailVC) {
            url = detailModel!.content_url!
        } else {
            url = item!.content_url!
        }
        let request = URLRequest(url: URL(string: url)!)
        webView.loadRequest(request)
        webView.delegate = self
        view.addSubview(webView)
    }

    func wjNavigationSettings() {
        let navArray = navigationController?.viewControllers
        let vc = navArray?[(navArray?.count)! - 2]
        if (vc is wjProductDetailVC) {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .plain, target: self, action: #selector(self.shareAction))
        }
    }

}

extension wjDetailContentVC {
    func shareAction() {
        // 分享
    }
}



extension wjDetailContentVC : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.setStatus("正在加载...")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
}
