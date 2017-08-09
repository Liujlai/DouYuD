//
//  ViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/4.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //         继承 UITabBarController
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Home")
    }
    
    //适配ios 8 storyBoard 分离 子控制器
    private func addChildVC(storyName:String){
        //        通过storboard获取控制器
        let childVc = UIStoryboard(name:"Home" , bundle: nil).instantiateInitialViewController()
        //        将childVc作为子控制器
        addChildViewController(childVc!)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
