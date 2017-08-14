//
//  CollectionHeaderView.swift
//  DYTV
//
//  Created by idea on 2017/8/8.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {


    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var moreBtn: UIButton!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    var group : AnchorGroup?{
        didSet{
            titleLable.text = group?.tag_name
//            好坑。。。😂从软件包里爬来的图片名，竟然和返回数据里的图片名有个单词不一样
//            home_herder_normal ≠ home_header_normal
            iconImageView.image = UIImage(named:group?.icon_name ?? "home_herder_normal")
        }
    }
    
}
//MARK: 从XIB中快速创建的类方法
extension CollectionHeaderView{
    class func collectionHeaderView() -> CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
