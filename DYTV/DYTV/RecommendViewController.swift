//
//  RecommendViewController.swift
//  推荐
//  DYTV
//
//  Created by idea on 2017/8/8.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit



let kCycleViewH = kScreenW * 3 / 8
let kGameviewH : CGFloat = 90



//标识

private let kHeaderViewID = "kHeaderViewID"

class RecommendViewController: BaseAnchorViewController {
    
    
    //MARK: 懒加载属性
    lazy var recommendVM: RecommendViewModel = RecommendViewModel()
    
    
    
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
    
}
//MARK: -设置UI界面内容
extension RecommendViewController{
    override func setupUI(){
        super.setupUI()
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
    override func loadData(){
        //        给父类的viewModel进行赋值
        baseVm = recommendVM
        //        1.请求推荐数据
        recommendVM.requestData {
            self.collectionView.reloadData()
            
            //            2.将数据传递给GameView
            var groups = self.recommendVM.anchorGroups
            //            移除前两条数据
            groups.removeFirst()
            groups.removeFirst()
            //            添加更多分组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
            
            //            3.数据请求完成
            self.loadDataFinished()
            
        }
        //        2.请求轮播数据
        recommendVM.requestCycleData {
            self.cycleView.cycleModels = self.recommendVM.cycleModels
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1{
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            
            prettyCell.anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return prettyCell
            
        }else{
            return  super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNItemW, height: kNormalItemH)
    }
}
