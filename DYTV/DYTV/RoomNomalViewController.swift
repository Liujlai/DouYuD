//
//  RoomNomalViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/23.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class RoomNomalViewController: UIViewController ,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange

         }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        /* 注：设置自己的手势后，不需要再保持手势
//        依然保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        */
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear((animated))
    }

  
}
