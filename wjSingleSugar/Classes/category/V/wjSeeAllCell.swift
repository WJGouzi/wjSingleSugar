//
//  wjSeeAllCell.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/16.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

class wjSeeAllCell: UITableViewCell {

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var placeholderBtn: UIButton!
    
    var model : wjCateTopModel? {
        didSet {
            titleLabel.text = model!.title
            subtitleLabel.text = model!.subtitle
            let url = model!.cover_image_url
            backgroundImageView.kf.setImage(with: URL(string : url!), placeholder: nil, options: nil, progressBlock: nil) { (image, error, CacheType, urls) in
                self.placeholderBtn.isHidden = true
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImageView.layer.cornerRadius = kCornerRadius
        backgroundImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
