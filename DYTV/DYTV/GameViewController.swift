//
//  GameViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/12.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
//边缘间距
private let kEdgeMargin :CGFloat = 10
private let kItemW : CGFloat = (kScreenW  - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW  * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH: CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"


class GameViewController: UIViewController {
    
    //MARK:懒加载属性
    fileprivate lazy var  gameVM :GameViewModel = GameViewModel()
    fileprivate lazy var collectionView: UICollectionView  = { [ unowned  self ]  in
        //        1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        //        最小间距为0
        layout.minimumInteritemSpacing = 0
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        
        //        添加头部
        layout.headerReferenceSize = CGSize(width: kScreenH, height: kHeaderViewH)
        
        //      2.  创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        //为了让其显示，注册Cell
        collectionView.register( UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //        注册头部
        
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        
        collectionView.dataSource = self
        
        return collectionView
        }()
    fileprivate lazy var topHeaderView: CollectionHeaderView =  {
        let headerView = CollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y:  -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "shortvideo_column_dot")
        headerView.titleLable.text = "常用"
        //        把button隐藏起来
        headerView.moreBtn.isHidden = true
        return headerView
    
    }()
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
        
    }()
    
    //MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        loadData()
        
        
    }
    
}

//MARK： 设置UI界面
extension GameViewController{
    fileprivate func setupUI(){
//        1.添加UICollectionView
        view.addSubview(collectionView)
//        2.添加顶部的HeaderView
        collectionView.addSubview(topHeaderView)
        //       3. 将常用游戏的View，添加到collectionView中
        collectionView.addSubview(gameView)
//        为了不用往下拖动就显示，设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)

    }
}
//MARK: 请求数据
extension GameViewController{
    fileprivate func loadData(){
        gameVM.loadAllGameData {
//            1.显示全部游戏
            self.collectionView.reloadData()
//            2.展示常用游戏
//            var tempArray = [BaseGameModel]()
//            for i in 0..<10{
//                tempArray.append(self.gameVM.game[i])
//            }
//
//            self.gameView.groups = tempArray
            self.gameView.groups = Array(self.gameVM.game[0..<10])
            
        }
    }
}


//MARK:   遵守UICollectionView 的数据源&代理
extension GameViewController :  UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.game.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as!  CollectionGameCell
        
        
        //        设置随机背景颜色
        //        cell.backgroundColor = UIColor.randomColor()
        
        cell.baseGame =  gameVM.game[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //        1.取出HearderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
//        2.给HeaderView设置属性
        headerView.titleLable.text = "全部"
        headerView.iconImageView.image = UIImage(named: "shortvideo_column_dot")
//        把button隐藏起来
        headerView.moreBtn.isHidden = true
        return headerView
    }
    
}
