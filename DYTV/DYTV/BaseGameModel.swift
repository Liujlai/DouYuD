//
//  BaseGameModel.swift
//  DYTV
//
//  Created by idea on 2017/8/12.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    //MARK:定义属性
    var tag_name:String = ""
    var icon_url :String = ""
    
    
    override init() {
        
    }
    
    //   MARK: 自定义构造函数
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    //因为有些键是没有用到的重写 方法
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
