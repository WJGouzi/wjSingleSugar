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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wjSetUpUISettings()
    }
}

extension wjProductVC {
    func wjSetUpUISettings() {
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


extension wjProductVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellIden, for: indexPath) as! wjProductCell
        
        return cell
    }
}


extension wjProductVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("123")
    }
}

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


