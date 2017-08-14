//
//  wjDetailTopScrollView.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/14.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class wjDetailTopScrollView: UIView {

    // 属性
    var imageUrls = [String]()
    
    // 懒加载
    
    // scrollview
    lazy var topScrollView : UIScrollView = {
        let topScroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: SCREENW, height: 375))
        topScroll.backgroundColor = UIColor.white
        topScroll.delegate = self
        topScroll.isPagingEnabled = true
        topScroll.bounces = true
        topScroll.showsHorizontalScrollIndicator = false
        topScroll.showsVerticalScrollIndicator = false
        return topScroll
    }()
    
    // pageIndicator
    lazy var pageIndicator : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = wjGlobalRedColor()
        pageControl.pageIndicatorTintColor = wjGlobalColor()
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    
    // 标题
    lazy var titleLabel : UILabel = {
        let titleL = UILabel()
        titleL.numberOfLines = 0
        titleL.textColor = UIColor.black
        return titleL
    }()
    
    // 价格
    lazy var priceLabel : UILabel = {
        let priceL = UILabel()
        priceL.textColor = wjGlobalRedColor()
        priceL.font = UIFont.systemFont(ofSize: 16.0)
        return priceL
    }()
    
    lazy var productDescription : UILabel = {
        let descriptionL = UILabel()
        descriptionL.textColor = wjColor(r: 0, g: 0, b: 0, a: 0.6)
        descriptionL.numberOfLines = 0
        descriptionL.font = UIFont.systemFont(ofSize: 15.0)
        return descriptionL
    }()
    
    // Setter方法
    var productItem : wjProductModel? {
        didSet {
            imageUrls = productItem!.image_urls!
            for (index,value) in imageUrls.enumerated() {
                // 循环的创建scrollview的imageview
                let rect = CGRect(x: SCREENW * CGFloat(index), y: 0, width: SCREENW, height: SCREENW)
                let imageView = UIImageView(frame: rect)
                imageView.kf.setImage(with: URL(string: value)!, placeholder: UIImage(named : "PlaceHolderImage_small_31x26_"), options: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                }
                topScrollView.addSubview(imageView)
            }
            topScrollView.contentSize = CGSize(width: SCREENW * CGFloat(imageUrls.count), height: 0)
            pageIndicator.currentPage = 0
            pageIndicator.numberOfPages = imageUrls.count
            titleLabel.text = productItem!.name!
            priceLabel.text = " ￥ " + productItem!.price!
            productDescription.text = productItem!.describe!
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(topScrollView)
        addSubview(pageIndicator)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(productDescription)
        
        // 约束
        pageIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(topScrollView.centerX)
            make.centerY.equalTo(topScrollView.snp.bottom).offset(-30)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(topScrollView.snp.bottom).offset(5)
            make.right.equalTo(self.snp.right).offset(-5)
            make.height.equalTo(30)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(titleLabel.snp.right)
            make.height.equalTo(25)
        }
        
        productDescription.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(priceLabel.snp.bottom).offset(5)
            make.right.equalTo(titleLabel.snp.right)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- UIScrollViewDelegate
extension wjDetailTopScrollView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 滑动
        var count = pageIndicator.currentPage
        let offsetx = scrollView.contentOffset.x
        count = Int(offsetx / SCREENW + 0.5)
        pageIndicator.currentPage = count
    }
}
