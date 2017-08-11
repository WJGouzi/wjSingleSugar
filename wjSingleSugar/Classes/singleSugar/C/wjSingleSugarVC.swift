//
//  wjSingleSugarVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjSingleSugarVC: wjMainBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "单糖"
        wjNetworkTool.shareNetwork.wjLoadHomePageTopData { (wjChannels) in
            for channel in wjChannels {
                print(channel)
                
                
            }
        }
        
    }
}
