//
//  CollectionCycleCell.swift
//  DYTV
//
//  Created by idea on 2017/8/11.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {

    
//MARK:    控件属性
  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    //MARK: - 定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
