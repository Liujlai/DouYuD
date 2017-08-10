//
//  CollectionNomalCell.swift
//  DYTV
//
//  Created by idea on 2017/8/8.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class CollectionNomalCell: CollectionBaseCell {
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //    }
   
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK: - 定义模型属性
   override var anchor : AnchorModel?{
        didSet{
//            1.将属性传递给父类
            super.anchor = anchor
            //            2.房间名称
             roomNameLabel.text = anchor?.room_name
        }
    
    }
    
}
