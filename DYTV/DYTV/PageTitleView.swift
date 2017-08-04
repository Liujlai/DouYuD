//
//  PageTitleView.swift
//  DYTV
//
//  Created by idea on 2017/8/4.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class PageTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //MARK: -定义属性
    private var titles :[String]
    
    
    //MARK: -自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
