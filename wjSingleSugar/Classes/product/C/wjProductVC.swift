//
//  wjProductVC.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/11.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit

let productCellIden = "productCell"


class wjProductVC: wjMainBaseVC {

    // 属性
    weak var cellView : UICollectionView?
    
    var productModels = [wjProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjSetUpUISettings()
        wjCatchProductData()
    }
}

// MARK:- 创建界面
extension wjProductVC {
    func wjSetUpUISettings() {
        self.title = "单品"
        let cellView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        cellView.dataSource = self
        cellView.delegate = self
        cellView.backgroundColor = view.backgroundColor
        let nib = UINib(nibName: String(describing: wjProductCell.self), bundle: nil)
        cellView.register(nib, forCellWithReuseIdentifier: productCellIden)
        view.addSubview(cellView)
        self.cellView = cellView
    }
}



// MARK:- 获取数据
extension wjProductVC {
    func wjCatchProductData() {
        weak var weakSelf = self
        wjNetworkTool.shareNetwork.wjLoadProductPageData { (productModels) in
            weakSelf!.productModels = productModels
            weakSelf!.cellView!.reloadData()
        }
    }
}




// MARK:- UICollectionViewDataSource
extension wjProductVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.productModels.count)
        return self.productModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIden, for: indexPath) as! wjProductCell
        cell.model = self.productModels[indexPath.item]
        cell.delegate = self
        return cell
    }
}


// MARK:- UICollectionViewDelegate
extension wjProductVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = wjProductDetailVC()
        productDetailVC.model = self.productModels[indexPath.item]
        productDetailVC.title = "商品详情"
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension wjProductVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
}

// MARK:- wjProductCellDelegate
extension wjProductVC : wjProductCellDelegate {
    func wjLikeBtnClickAciton(_ btn: UIButton) {
        if !UserDefaults.standard.bool(forKey: isLogin) {
            
        } else {
            
        }
    }
}



