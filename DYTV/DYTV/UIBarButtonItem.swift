//
//  UIBarButtonItem.swift
//  DYTV
//
//  Created by idea on 2017/8/4.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    
//    类方法
    class func createItem(imageName: String,highImageName:String,size:CGSize) ->UIBarButtonItem {
        let btn  = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
    
//    便利构造函数 : 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数（self）
    
    convenience  init(imageName: String,highImageName:String,size:CGSize) {
        let btn  = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
   
        self.init(customView: btn)
    }
}
