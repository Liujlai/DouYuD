//
//  CollectionPrettyCell.swift
//  DYTV
//
//  Created by idea on 2017/8/9.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionPrettyCell: CollectionBaseCell {
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //    }
    //MAEK: -   控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    //MARK: - 定义模型属性
    override var anchor : AnchorModel?{
        didSet{
            //            1.将属性传递给父类
            super.anchor = anchor
            //            2.显示城市
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
    
}
