//
//  wjChannelModel.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjChannelModel: NSObject {
    var editable : Bool?
    var name : String?
    var id : Int?
    
    
    init(dict : [String : AnyObject]) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        editable = dict["editable"] as? Bool
    }
}
