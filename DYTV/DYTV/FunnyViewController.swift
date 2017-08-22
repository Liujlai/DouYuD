//
//  FunnyViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/22.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

private let kTopmargin: CGFloat = 8

class FunnyViewController: BaseAnchorViewController {

    

}


extension FunnyViewController{
    override func setupUI() {
        super.setupUI()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        将hearder设置为0
        layout.headerReferenceSize = CGSize.zero
//        设置顶部间距
        collectionView.contentInset = UIEdgeInsets(top: kTopmargin, left: 0, bottom: 0, right: 0)
        
    }
}
