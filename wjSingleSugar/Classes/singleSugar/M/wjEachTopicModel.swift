//
//  wjEachTopicModel.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjEachTopicModel: NSObject {

    // 属性
    var content_url : String?
    var cover_image_url : String?
    var created_at : Int?
    var id : Int?
    var liked : Bool?
    var likes_count : Int?
    var published_at : Int?
    var share_msg : String?
    var short_title : String?
    var status : Int?
    var template : String?
    var title : String?
    var type : String?
    var updated_at : Int?
    var url : String?
    
    init(dict : [String : AnyObject]) {
        super.init()
        content_url = dict["content_url"] as? String
        cover_image_url = dict["cover_image_url"] as? String
        created_at = dict["created_at"] as? Int
        id = dict["id"] as? Int
        liked = dict["liked"] as? Bool
        likes_count = dict["likes_count"] as? Int
        share_msg = dict["share_msg"] as? String
        published_at = dict["published_at"] as? Int
        short_title = dict["short_title"] as? String
        status = dict["status"] as? Int
        type = dict["type"] as? String
        title = dict["title"] as? String
        template = dict["template"] as? String
        updated_at = dict["updated_at"] as? Int
        url = dict["url"] as? String
    }
    
}
