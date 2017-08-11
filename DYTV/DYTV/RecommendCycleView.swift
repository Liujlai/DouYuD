//
//  RecommendCycleView.swift
//  DYTV
//
//  Created by idea on 2017/8/10.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

let kCycleCellID = "kCycleCellID"


class RecommendCycleView: UIView {
    //MARK: - 定义属性
    var cycleModels : [CycleModel]?{
        didSet{
//            1.刷新collectionView
            collectionView.reloadData()
//            2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    
    //控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    //    系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        //        注册Cell
        
        collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        //        设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.isPagingEnabled = true
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //        设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        //        左右进行滚动
        layout.scrollDirection = .horizontal
        
        collectionView.isPagingEnabled = true
    }
    
}


//MARK: - 提供一个快速创建View的类方法

extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        
    }
}

//MARK: - 遵守UICollectionView的数据源协议
extension RecommendCycleView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = cycleModels![indexPath.item]
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red :UIColor.blue
        return cell
    }
    
}


//MARK: -遵守UICollectonView的代理协议

extension RecommendCycleView : UICollectionViewDelegate{
//    监听滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        1.获取滚动的偏移量 ----->+ scrollView.bounds.width * 0.5 是滑动到一半的时候显示下一张
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
//        2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width)
    }
}
