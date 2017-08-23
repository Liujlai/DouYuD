//
//  BaseViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/23.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: 定义属性
    var contenView : UIView?
    
    
//    MARK：懒加载属性
    lazy var animImageView : UIImageView = {[unowned self] in
        let imageView = UIImageView(image: UIImage(named: "yubaSDK_loading_shark1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named:"yubaSDK_loading_shark1")!,UIImage(named : "yubaSDK_loading_shark2")!]
//        0.5秒切换动画
        imageView.animationDuration = 0.5
//        范围设置一个很大的整数
        imageView.animationRepeatCount = LONG_MAX
//        随父控件的拉伸位置调整-->位置居中
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
//    MARK：系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

extension BaseViewController{
    func setupUI(){
//        隐藏内容的View
        contenView?.isHidden =  true
        
        
//        添加执行动画UIImageView
        view.addSubview(animImageView)
        
//        给animImageView执行动画
        animImageView.startAnimating()
        
//        设置view的背景颜色
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
    }
    
    
//    隐藏加载动画显示内容
    func loadDataFinished(){
//        1.停止动画
        animImageView.startAnimating()
//        2.隐藏animUmageView
        animImageView.isHidden = true
//        3.显示内容view
        contenView?.isHidden = false
        
    }
}
