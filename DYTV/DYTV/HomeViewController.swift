//
//  HomeViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/4.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
}

//MARK : -设置UI界面
extension HomeViewController{
    func setupUI(){
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar(){
//1.设置首页导航栏左侧 logo Item
        let btn  = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
//2.    设置右侧的Item
        
        let size = CGSize(width: 40, height: 40) //更改 Item的的大小
//        调用构造方法
        let historyItem = UIBarButtonItem(imageName: "history_btn_pk", highImageName: "", size: size)
//        调用类方法
//        let historyItem = UIBarButtonItem.createItem(imageName: "history_btn_pk", highImageName: "", size: size)
        
        let searchItem = UIBarButtonItem.createItem(imageName: "searchBtnIconHL", highImageName: "", size: size)
        
        let  qrcodeItem = UIBarButtonItem.createItem(imageName: "scanIconHL", highImageName: "", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
