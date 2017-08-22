//
//  AmuseMenuViewCell.swift
//  DYTV
//
//  Created by idea on 2017/8/22.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    
    //MARK: - 数组模型
    var  groups : [AnchorGroup]?{
        didSet{
            collection.reloadData()
        }
    }
    
    

    @IBOutlet weak var collection: UICollectionView!
    
    //MARK: 从Xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collection.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout  = collection.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW  = collection.bounds.width / 4
        let itemH =  collection.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }

}
extension AmuseMenuViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
//        cell.backgroundColor = UIColor.randomColor()
        cell.baseGame = groups![indexPath.item]
        //        删除的那条线
        cell.clipsToBounds = true
        return cell
        
    }
}
