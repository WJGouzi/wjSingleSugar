//
//  wjProductCell.swift
//  wjSingleSugar
//
//  Created by gouzi on 2017/8/13.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import Kingfisher


protocol wjProductCellDelegate : NSObjectProtocol {
    func wjLikeBtnClickAciton(_ btn : UIButton)
}

class wjProductCell: UICollectionViewCell {

    weak var delegate : wjProductCellDelegate?
    
    @IBOutlet weak var placeholderBtn: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likedBtn: UIButton!
    @IBOutlet weak var pricrLabel: UILabel!
    
    var model : wjProductModel? {
        didSet {
            let url = model!.cover_image_url!
            backgroundImageView.kf.setImage(with: URL(string: url)!, placeholder: nil, options: nil, progressBlock: nil) { (image, error, CacheType, imageUrl) in
                self.placeholderBtn.isHidden = true
            }
            pricrLabel.text = "￥" + model!.price!
            likedBtn.setTitle(" " + String(model!.favorites_count!) + " ", for: .normal)
            titleLabel.text = model!.name!
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

    
    @IBAction func wjLikedBtnClickAction(_ sender: UIButton) {
        delegate?.wjLikeBtnClickAciton(sender)
    }
}
