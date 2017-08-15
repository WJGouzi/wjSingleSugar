//
//  wjCateTopScrollview.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/15.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import Kingfisher

protocol wjCategoryDelegate {
    // 加载更多的按钮的点击事件
    func wjLoadMoreBtnAction()
    
    // 点击图片的点击事件
    func wjImageViewDidSelected(_ model : wjCateTopModel)
}

class wjCateTopScrollview: UIView {

    
    // 属性
    var delegate : wjCategoryDelegate?
    
    lazy var titleView : UIView = {
        let titleView = UIView()
        titleView.backgroundColor = UIColor.white
        return titleView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.textColor = UIColor.gray
        titleL.font = UIFont.systemFont(ofSize: 16.0)
        titleL.text = "专题合集"
        return titleL
    }()
    lazy var loadMoreBtn: UIButton = {
        let loadMore = UIButton()
        loadMore.setTitleColor(UIColor.lightGray, for: .normal)
        loadMore.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        loadMore.setTitle("查看全部>", for: .normal)
        return loadMore
    }()
    lazy var contentView: UIView = {
        let content = UIView()
        content.backgroundColor = UIColor.white
        return content
    }()
    
    var cateTopModels : [wjCateTopModel] = [] {
        didSet {
            print(cateTopModels.count)
            // 循环创建scrollview
            let backW = CGFloat(150)
            for (index, value) in cateTopModels.enumerated() {
                let rect = CGRect(x: CGFloat(index) * backW, y: 0, width: backW, height: self.subjectScrollView.height)
                let backView = UIView(frame: rect)
                backView.isUserInteractionEnabled = true
                let imageView = UIImageView()
                imageView.frame = CGRect(x: 5, y: 0, width: backView.width - 10, height: backView.height)
                imageView.kf.setImage(with: URL(string : value.banner_image_url!), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
                imageView.isUserInteractionEnabled = true
                imageView.tag = index
                // 添加手势
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.wjImageViewDidSelected(_ :)))
                imageView.addGestureRecognizer(tap)
                
                
                backView.addSubview(imageView)
                self.subjectScrollView.addSubview(backView)
            }
            self.subjectScrollView.contentSize = CGSize(width: CGFloat(cateTopModels.count) * backW, height: 0)
        }
    }
    

    lazy var subjectScrollView : UIScrollView = {
        let subjectView = UIScrollView()
        subjectView.showsHorizontalScrollIndicator = false
        return subjectView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleView)
        addSubview(contentView)
        
        titleView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(40)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.bottom.right.equalTo(self)
        }
        
        titleView.addSubview(titleLabel)
        titleView.addSubview(loadMoreBtn)
        loadMoreBtn.addTarget(self, action: #selector(self.wjLoadMoreAction), for: .touchUpInside)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleView.snp.centerY)
            make.left.equalTo(titleView.snp.left).offset(5)
        }
        loadMoreBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.right.equalTo(titleView.snp.right).offset(-5)
        }
        
        contentView.addSubview(subjectScrollView)
        subjectScrollView.snp.makeConstraints { (make) in
            make.left.top.bottom.right.equalTo(contentView)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = UIColor.gray
        loadMoreBtn.setTitleColor(UIColor.lightGray, for: .normal)
        
    }
}


extension wjCateTopScrollview {
    func wjLoadMoreAction() {
        delegate?.wjLoadMoreBtnAction()
    }
    
    // 点击手势
    func wjImageViewDidSelected(_ tap : UITapGestureRecognizer) {
        delegate?.wjImageViewDidSelected(cateTopModels[tap.view!.tag])
    }
}

