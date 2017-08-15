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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = wjTabBarVC()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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


