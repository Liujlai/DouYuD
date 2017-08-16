//
//  AmuseViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/15.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit


private let kItemMargin: CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin)/2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

//标识
//let kNormalCellID = "kNormalCellID"
//let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"
class AmuseViewController: UIViewController {
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    lazy var collectionView: UICollectionView = {[unowned self] in
        //        1.创建布局
        //        流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
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
extension AmuseViewController{
    fileprivate func  setupUI(){
        view.addSubview(collectionView)
    }
}

//MARK: 请求数据 
extension AmuseViewController{
    fileprivate func loadData(){
        amuseVM.loadAmusedata {
//            将请求到的数据发信给collectionView
            self.collectionView.reloadData()
        }

    }
}

//MARK: 遵守UICollectionView的数据源&代理协议
extension AmuseViewController : UICollectionViewDataSource,UICollectionViewDelegate{
//有几组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count
    }
//    每组里🈶️几条数据
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
//    返回CELL放入方法
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        1.取出CEll
//        选择cell测类型---->为普通cell（kNormalCellID）
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
        
//        2.给Cell设置数据
       cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        return cell
    }
//    另一个数据源方法
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
//        2.给Headerview设置数据
        headerView.group = amuseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}
