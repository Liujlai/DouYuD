//
//  BaseAnchorViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/16.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
 let kNItemW = (kScreenW - 3 * kItemMargin)/2
 let kNormalItemH = kNItemW * 3 / 4
 let kPrettyItemH = kNItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

//标识
private let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"



class BaseAnchorViewController: UIViewController {
    
    
    var baseVm : BaseViewModel!
    
    lazy var collectionView: UICollectionView = {[unowned self] in
        //        1.创建布局
        //        流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNItemW, height: kNormalItemH)
        //        行间距
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        //        设置组的内边距
        layout .sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //        2.创建UICollection
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        //        添加数据源
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //        随父控件的缩小而缩小
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName:"CollectionNomalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UINib(nibName:"CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        //                 collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName:"CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        return collectionView
        }()

    

    override func viewDidLoad() {
        super.viewDidLoad()

                setupUI()
                loadData()
    
    }


}

//MARK:设置UI界面
extension BaseAnchorViewController{
     func  setupUI(){
        view.addSubview(collectionView)
    }
}

//MARK: 请求数据
extension BaseAnchorViewController{
    func loadData(){
        
        }
    
    }

//MARK: 遵守UICollectionView的数据源&代理协议
extension BaseAnchorViewController : UICollectionViewDataSource{
    //有几组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if baseVm == nil {
            return 1
        }
        
        return baseVm.anchorGroups.count
    }
    //    每组里🈶️几条数据
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if baseVm == nil {
            return 20
        }
        return baseVm.anchorGroups[section].anchors.count
    }
    //    返回CELL放入方法
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        1.取出CEll
        //        选择cell测类型---->为普通cell（kNormalCellID）
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
        if baseVm == nil {
            return cell
        }
        //        2.给Cell设置数据
        cell.anchor = baseVm.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
    //    另一个数据源方法
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //        1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        if baseVm == nil {
            return headerView
        }
        //        2.给Headerview设置数据
        headerView.group = baseVm.anchorGroups[indexPath.section]
        
        return headerView
    }
}
extension BaseAnchorViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击: \(indexPath)")
    }

}
