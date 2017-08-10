//
//  CollectionBaseCell.swift
//  DYTV
//
//  Created by idea on 2017/8/10.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //MARK : 控件属性
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    //MARK: - 定义模型属性
    var anchor : AnchorModel?{
        didSet{
            //        校验模型是否有值
            guard let anchor = anchor else { return}
            
            
            //    1. 取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
            } else{
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            //            2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            //            4.显示封面图片
            guard  let iconURL = URL(string: anchor.vertical_src) else{ return }
            
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
