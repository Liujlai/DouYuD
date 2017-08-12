//
//  RecommendGameView.swift
//  DYTV
//
//  Created by idea on 2017/8/11.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

let kGameCellID = "kGameCellID"


class RecommendGameView: UIView {
    
    //MARK：    定义数据的属性
    var groups: [AnchorGroup]?{
        didSet{
//            1.移除前两组数据
            groups?.removeFirst()
            groups?.remove(at: 0)
//            2.添加更多组
            let moveGroup = AnchorGroup()
            moveGroup.tag_name = "更多"
            groups?.append(moveGroup)
//            3.刷新表格
            collectionView.reloadData()
        }
    }
    //MARK: 控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //        注册Cell
        collectionView.register( UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
    }
    
    
}


//MARK: 提供快速创建的类方法
extension RecommendGameView{
    class func recommendGameView() ->RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}


//MARK: 遵守UICollectionView的数据源协议

extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.cyan : UIColor.blue
        
        
        return cell
    }
}
