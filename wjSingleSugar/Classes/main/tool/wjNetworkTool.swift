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
    /// 属性
    static let shareNetwork =  wjNetworkTool()
    
    // MARK:- 单糖页面的数据请求
    /// 获取首页的顶部的选择的数据
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

    /// 获取首页的各个标签的内容
    func wjLoadHomePageEachLabelData(id : Int, finished : @escaping (_ eachLabelItem : [wjEachTopicModel])->()) {
        let url = BASE_URL + "v1/channels/\(id)/items"
        let param = ["gender" : 1,
                     "generation" : 1,
                     "limit" : 20,
                     "offset" : 0]
        Alamofire.request(url, parameters: param).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
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
    
    
    // MARK:- 单品页面的数据请求
    /// 单品页面的数据
    func wjLoadProductPageData(finished : @escaping (_ productItems : [wjProductModel])->()) {
        let url = BASE_URL + "v2/items"
        let param = [
            "gender": 1,
            "generation": 1,
            "limit": 20,
            "offset": 0
        ]
        Alamofire.request(url, parameters: param).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary {
                    if let items = data["items"]?.arrayObject {
                        var products = [wjProductModel]()
                        for product in items {
                            let productDict = product as! [String : AnyObject]
                            if let eachProductData = productDict["data"] {
                                let eachProduct = wjProductModel(dict: eachProductData as! [String : AnyObject])
                                products.append(eachProduct)
                            }
                        }
                        finished(products)
                    }
                }
            }
        }
    }
    
    
    /// 获取单品详情的数据
    func wjLoadEachProductItemIntroduceData(id : Int, finished: @escaping (_ productDetailItem : wjProductDetailModel)->()) {
        let url = BASE_URL + "v2/items/\(id)"
        Alamofire.request(url).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionaryObject {
                    let productItem = wjProductDetailModel(dict: data as [String : AnyObject])
                    finished(productItem)
                }
            }
        }
    }
    
    
    // 单品列表中每个商品的评论
    func wjLoadEachProductComments(id : Int, finished : @escaping(_ comments : [wjCommentModel])->()) {
        let url = BASE_URL + "v2/items/\(id)/comments"
        let param = ["limit": 20,
                      "offset": 0]
        Alamofire.request(url, parameters: param).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
                let data = dict["data"].dictionary
                if let comments = data!["comments"]?.arrayObject {
                    var commentItems = [wjCommentModel]()
                    for comment in comments {
                        let eachItem = wjCommentModel(dict: comment as! [String : AnyObject])
                        commentItems.append(eachItem)
                    }
                    finished(commentItems)
                }
            }
        }
    }
    
    // MARK:- 分类页面的请求
    /// 分类页面顶部的scrollview的展示的图片
    func wjLoadCategoryTopCollection(limit: Int, finished:@escaping (_ collections: [wjCateTopModel]) -> ()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/collections"
        let params = ["limit": limit,
                      "offset": 0]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
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
                if let data = dict["data"].dictionary {
                    if let cateTopDatas = data["collections"]?.arrayObject {
                    var cateTopModels = [wjCateTopModel]()
                    for item in cateTopDatas {
                        let collection = wjCateTopModel(dict: item as! [String: AnyObject])
                        cateTopModels.append(collection)
                        }
                        finished(cateTopModels)
                    }
                }
            }
        }
    }

    
    // 展示每个分类的详情列表
    func wjLoadEachCategoryDetailData(id : Int , finished : @escaping (_ model : [wjCateDetailModel])->()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/collections/\(id)/posts"
        let param = ["gender" : 1,
                     "generation" : 1,
                     "limit" : 20,
                     "offset" : 0]
        
        Alamofire.request(url, parameters: param).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary {
                    if let posts = data["posts"]?.arrayObject {
                        var postsModels = [wjCateDetailModel]()
                        for post in posts {
                            let postDict = wjCateDetailModel(dict: post as! [String : AnyObject])
                            postsModels.append(postDict)
                        }
                        finished(postsModels)
                    }
                }
            }
        }
    }
    
    
    /// 风格和品类的数据请求
    func wjLoadStyleAndClassData(finished:@escaping (_ groups: [AnyObject])->()) {
        SVProgressHUD.show(withStatus: "正在加载...")
        let url = BASE_URL + "v1/channel_groups/all"
        Alamofire.request(url).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary {
                    if let channel_groups = data["channel_groups"]?.arrayObject {
                       
                        var channlGroups = [AnyObject]()
                        for channel_group in channel_groups {
                            var groups = [wjGroupModel]()
                            let channel_groupDict = channel_group as! [String : AnyObject]
                            let channels = channel_groupDict["channels"] as! [AnyObject]
                            for channel in channels {
                                let group = wjGroupModel(dict: channel as! [String : AnyObject])
                                groups.append(group)
                            }
                            channlGroups.append(groups as AnyObject)
                        }
                        finished(channlGroups)
                    }
                }
            }
        }
    }
    
    
    /// 点击风格品类的每个collectionView的展示界面
    func wjLoadEachStyleAndClassCellData(id : Int, finished: @escaping(_ model : [wjCateDetailModel])->()) {
        SVProgressHUD.show(withStatus: "正在加载")
        let url = BASE_URL + "v1/channels/\(id)/items"
        let param = [
            "limit" : 40,
            "offset" : 0
        ]
        Alamofire.request(url, parameters: param).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary {
                    if let posts = data["posts"]?.arrayObject {
                        var postsModels = [wjCateDetailModel]()
                        for post in posts {
                            let postDict = wjCateDetailModel(dict: post as! [String : AnyObject])
                            postsModels.append(postDict)
                        }
                        finished(postsModels)
                    }
                }
            }
        }
    }
    
    /// 分类页面加载所有的列表
    func wjLoadDetailCellData(url : String, param : [String : AnyObject] , arrayName : String ,finished : @escaping(_ model : [wjCateDetailModel])->()) {
        SVProgressHUD.show(withStatus: "正在加载")
        Alamofire.request(url, parameters: param).responseJSON { (response) in
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
                SVProgressHUD.dismiss()
                if let data = dict["data"].dictionary {
                    if let posts = data[arrayName]?.arrayObject {
                        var postsModels = [wjCateDetailModel]()
                        for post in posts {
                            let postDict = wjCateDetailModel(dict: post as! [String : AnyObject])
                            postsModels.append(postDict)
                        }
                        finished(postsModels)
                    }
                }
            }
        }

    }


}
