//
//  AmuseViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/15.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class AmuseViewController: BaseAnchorViewController {
    fileprivate lazy var amuseVM: AmuseViewModel = AmuseViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
//        menuView.backgroundColor = UIColor.purple
        return menuView
    
    }()
    
}
//MARK: - 设置UI界面
extension AmuseViewController{
    override func setupUI() {
        super.setupUI()
//        将菜单的view添加进来
        collectionView.addSubview(menuView)
        collectionView.contentInset =  UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


//MARK: 请求数据
extension AmuseViewController{
    override func loadData(){
        
        //            给父类定义的baseVm赋值
        baseVm =  amuseVM
        
        //        请求数据
        amuseVM.loadAmusedata {
            //            将请求到的数据发信给collectionView
            self.collectionView.reloadData()
            var tempGroups =  self.amuseVM.anchorGroups
//            删除第一个
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
        }
        
    }
}

