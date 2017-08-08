//
//  RecommendViewController.swift
//  推荐
//  DYTV
//
//  Created by idea on 2017/8/8.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

let kItemMargin: CGFloat = 10
let kItemW = (kScreenW - 3 * kItemMargin)/2
let kItemH = kItemW * 3 / 4
let kHeaderViewH : CGFloat = 50
//标识
let kNormalCellID = "kNormalCellID"
let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {

    
    //MARK: 懒加载属性
    lazy var collectionView: UICollectionView = {[unowned self] in
//        1.创建布局
//        流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
//        行间距
        layout.minimumLineSpacing = 0
        
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
//        设置组的内边距
        layout .sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
//        2.创建UICollection
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.blue
//        添加数据源
        collectionView.dataSource = self
//        随父控件的缩小而缩小
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

//        view.backgroundColor = UIColor.purple
//        设置U界面
        setupUI()
        
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
//MARK: -设置UI界面内容
extension RecommendViewController{
     func setupUI(){
//      1. 将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
    }
}
//MARK : - 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource{
//    有多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
//    每组有
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 8
        }
            return 4
        
     }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
  
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1. 取出section的HearderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        headerView.backgroundColor = UIColor.green
        return headerView
    }
}


