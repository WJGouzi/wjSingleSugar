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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjSetWebView()
    }
}


extension wjDetailContentVC {
    func wjSetWebView() {
        let webView = UIWebView()
        webView.frame = view.bounds
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        let url = item!.content_url!
        let request = URLRequest(url: URL(string: url)!)
        webView.loadRequest(request)
        webView.delegate = self
        view.addSubview(webView)
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
