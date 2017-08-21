//
//  AppDelegate.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var wbtoken : String?
    var wbCurrentUserID : String?
    var wbRefreshToken : String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 微博
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(String(weboAppKey))
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = wjTabBarVC()
        return true
    }
    
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        wjLog("url is  : \(url),\n self is \(self)")
        return WeiboSDK.handleOpen(url, delegate: self as? WeiboSDKDelegate)
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WeiboSDK.handleOpen(url, delegate: self as? WeiboSDKDelegate)
    }
    
    
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        
    }
    
    
    func didReceiveWeiboResponse(response : WBBaseResponse!) {

        if response is WBSendMessageToWeiboResponse {
            let title = NSLocalizedString("发送结果", comment: "")
            let message = NSLocalizedString("响应状态", comment: "") + String(describing: response.statusCode) + NSLocalizedString("响应UserInfo数据", comment: "") + NSLocalizedString("原请求UserInfo数据", comment: "")
            let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "确定")
            let sendMessageToWeiboResponse = response as! WBSendMessageToWeiboResponse
            let accessToken = sendMessageToWeiboResponse.authResponse.accessToken
            if let accessToken = accessToken {
                wbtoken = accessToken
            }
            let userId = sendMessageToWeiboResponse.authResponse.userID
            if let userID = userId {
                wbCurrentUserID = userID
            }
            alert.show()
        } else if response is WBAuthorizeResponse {
            let title = NSLocalizedString("认证结果", comment: "");
            let message = NSLocalizedString("响应状态", comment: "") + String(describing: response.statusCode) + String((response as! WBAuthorizeResponse).userID) + String((response as! WBAuthorizeResponse).accessToken) + NSLocalizedString("响应UserInfo数据", comment: "") + String(describing: response.userInfo.values) + NSLocalizedString("原请求UserInfo数据", comment: "")
             let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "确定")
            wbtoken = (response as! WBAuthorizeResponse).accessToken
            wbCurrentUserID = (response as! WBAuthorizeResponse).userID
            wbRefreshToken = (response as! WBAuthorizeResponse).refreshToken
            alert.show()
        }
    }
    
}




// MARK:- 设置成全局的东西
/// 封装一个方法进行打印
func wjLog<T>(_ message : T ,file : String = #file, funcName : String = #function, lineNumber : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("file:\(fileName) function:\(funcName) line:\(lineNumber) -- \(message)")
    #endif
}

// 需求是设置成全局都可以打印--并不是属于某个类和对象的
func WJLog<T>(_ message : T ,file : String = #file, lineNumber : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("file:\(fileName) line:\(lineNumber) -- \(message)")
    #endif
}

// 在swift中没有宏定义,可以在buildSetting -> swift flag -> debug 添加一个 ： -D DEBUG,让系统去查找。


