//
//  wjSettingCell.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjSettingCell: UITableViewCell {
    
    // 属性
    var settingModel : wjSettingModel? {
        didSet{
            iconImageView.image = UIImage(named: settingModel!.iconImage!)
            leftLabel.text = settingModel!.leftTitle
            rightLabel.text = settingModel!.rightTitle
            disclosureIndicator.isHidden = settingModel!.isHiddenRightTip!
            switchView.isHidden = settingModel!.isHiddenSwitch!
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightLabel: UILabel!
    
    @IBOutlet weak var disclosureIndicator: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
