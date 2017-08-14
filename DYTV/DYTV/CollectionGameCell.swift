//
//  CollectionGameCell.swift
//  DYTV
//
//  Created by idea on 2017/8/12.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
//MARK: 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    //MARK: 定义模型属性
    var  baseGame :BaseGameModel?{
        didSet{
            titleLabel.text = baseGame?.tag_name
//            强行解包，因为拿到的事可选类型
            let iconURL = URL(string: baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL , placeholder : UIImage(named: "btn_H5_more"))
            

        }
    }
    
   
}
