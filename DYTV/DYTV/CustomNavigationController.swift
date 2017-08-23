//
//  CustomNavigationController.swift
//  DYTV
//
//  Created by idea on 2017/8/23.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
//        2.获取手势添加到view中
        guard  let  gasView = systemGes.view  else{ return }
//        3,获取target／action
//        3.1利用运行时机制查看所有的属性名称
       /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar  = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
            
        }
        */
        let targets  = systemGes.value(forKey: "_targets") as? [NSObject]
        guard  let targetobjc = targets?.first else { return }
//        print(targetobjc)

//        3.2 取出target
        guard let target = targetobjc.value(forKey: "target") else { return  }
//        3.3取出Action
//        guard   let action  = targetobjc.value(forKey: "action") as? Selector else  { return }
        let action  = Selector(("handleNavigationTransition:"))
        
//        4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gasView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
        
        
        
        

    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
//        隐藏push控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: animated)
    }

    
}
