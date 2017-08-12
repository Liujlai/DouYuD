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
private let kItemW = (kScreenW - 3 * kItemMargin)/2
let kNormalItemH = kItemW * 3 / 4
let kPrettyItemH = kItemW * 4 / 3
let kHeaderViewH : CGFloat = 50

let kCycleViewH = kScreenW * 3 / 8
let kGameviewH : CGFloat = 90



//标识
let kNormalCellID = "kNormalCellID"
let kPrettyCellID = "kPrettyCellID"
let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: UIViewController {
    
    
    //MARK: 懒加载属性
    lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
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
    
    lazy var cycleView: RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameviewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    
    lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameviewH, width: kScreenW, height: kGameviewH)
        return gameView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = UIColor.purple 
        //        设置U界面
        setupUI()
        
        //        发送网络请求
        loadData()
        
        
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
        // 2.将CycleView添加到UICollection
        collectionView.addSubview(cycleView)
//        3.将gameView添加collectionView
        collectionView.addSubview(gameView)
        
        //4. 设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameviewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: -请求数据
extension RecommendViewController{
    func loadData(){
        //        1.请求推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            
//            2.将数据传递给GameView
            self.gameView.groups = self.recommendVM.anchorGroups
        }
        //        2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

//MARK : - 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    //    有多少组
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    //    每组有
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group = recommendVM.anchorGroups[section]
        
        //        if section == 0 {
        //            return 8
        //        }
        return group.anchors.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /**
         //1.获取Cell
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
         //        cell.backgroundColor = UIColor.red
         */
        //        1.取出Cell
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        //         2.定义Cell
        var cell:CollectionBaseCell!
        
        //       3.取出Cell
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNomalCell
            
        }
        //        4.将模型赋值给Cell
        cell.anchor = anchor
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1. 取出section的HearderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        //        2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        
        
        //        headerView.backgroundColor = UIColor.green
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}


