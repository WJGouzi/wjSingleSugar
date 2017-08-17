//
//  wjEachPageCell.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/12.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import Kingfisher


protocol wjEachTopicCellDelegate : NSObjectProtocol {
    func wjLikedBtnClickedAction(likedBtn : UIButton)
}



class wjEachPageCell: UITableViewCell {

    weak var delegate : wjEachTopicCellDelegate?
    
    // 属性
    @IBOutlet weak var placeHolderBtn: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var likedBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item : wjEachTopicModel? {
        didSet {
            let url = item?.cover_image_url
            backgroundImageView.kf.setImage(with: URL(string : url!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, CacheType, imageUrl) in
                self.placeHolderBtn.isHidden = true
            }
            titleLabel.text = item!.title!
            likedBtn.setTitle(" " + String(describing: item!.likes_count!) + " ", for: .normal)
        }
    }
    
    // 分类的具体展示的模型
    var detailModel : wjCateDetailModel? {
        didSet {
            let url = detailModel?.cover_image_url
            backgroundImageView.kf.setImage(with: URL(string : url!)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, CacheType, imageUrl) in
                self.placeHolderBtn.isHidden = true
            }
            titleLabel.text = detailModel!.title!
            likedBtn.setTitle(" " + String(describing: detailModel!.likes_count!) + " ", for: .normal)
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likedBtn.setImage(UIImage(named: "content-details_like_selected_16x16_"), for: .selected)
        likedBtn.layer.cornerRadius = likedBtn.height * 0.5
        likedBtn.layer.masksToBounds = true
        likedBtn.layer.rasterizationScale = UIScreen.main.scale
        likedBtn.layer.shouldRasterize = true
        backgroundImageView.layer.cornerRadius = kCornerRadius
        backgroundImageView.layer.masksToBounds = true
        backgroundImageView.layer.shouldRasterize = true
        backgroundImageView.layer.rasterizationScale = UIScreen.main.scale
    }

    
    // 喜欢按钮的点击事件
    @IBAction func wjLikedBtnClickAction(_ sender: UIButton) {
        delegate?.wjLikedBtnClickedAction(likedBtn: sender)
    }
    
}
