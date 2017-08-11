//
//  wjNetworkTool.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class wjNetworkTool: NSObject {
    static let shareNetwork =  wjNetworkTool()
    
    // 获取首页的顶部的选择的数据
    func wjLoadHomePageTopData(finished : @escaping (_ wj_channels:[wjChannelModel])->()) {
        let url = BASE_URL + "v2/channels/preset"
        let param = [
            "gender" : 1,
            "generation" : 1
        ]
        
        // 请求
        Alamofire.request(url, parameters: param).responseJSON { (response) in
            guard  response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                SVProgressHUD.dismiss()
                let data = dict["data"].dictionary
                
                // 选择含有精选的数组
                if let channels = data!["channels"]?.arrayObject {
                    var wjChannels = [wjChannelModel]()
                    for channel in channels {
                        let wjChannel = wjChannelModel(dict: channel as! [String : AnyObject])
                        wjChannels.append(wjChannel)
                    }
                    finished(wjChannels)
                }
            }
        }
    }

    // 获取首页的各个标签的内容
    func wjLoadHomePageEachLabelData(id : Int, finished : @escaping (_ eachLabelItem : [wjEachTopicModel])->()) {
        let url = BASE_URL + "v1/channels/\(id)/items"
        let param = ["gender" : 1 ,
                     "generation" : 1 ,
                     "limit" : 20 ,
                     "offset" : 0]
        Alamofire.request(url, parameters: param).responseJSON { (response) in
            print(response)
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            if let value = response.result.value {
                let dict = JSON(value)
                let code = dict["code"].intValue
                let message = dict["message"].stringValue
                guard code == RETURN_OK else {
                    SVProgressHUD.showInfo(withStatus: message)
                    return
                }
                let data = dict["data"].dictionary
                if let items = data!["items"]?.arrayObject {
                    var eachItems = [wjEachTopicModel]()
                    for item in items {
                        let eachItem = wjEachTopicModel(dict: item as! [String : AnyObject])
                        eachItems.append(eachItem)
                    }
                    finished(eachItems)
                }
            }
        }
    }
    
    
    

}
