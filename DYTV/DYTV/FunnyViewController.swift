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
//MARK: -懒加载ViewModel对象
    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    
    

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



extension FunnyViewController{
    override func loadData() {
       //1.给父类中的ViewModel进行赋值
        baseVm = funnyVM
        
        //2.请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            //            3.数据请求完成
            self.loadDataFinished()
        }
    }
}
