//
//  HomeViewController.swift
//  DYTV
//
//  Created by idea on 2017/8/4.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
private let kTitleH:CGFloat = 40

class HomeViewController: UIViewController {
    //MARK:-    懒加载属性
    lazy var pageTitleView: PageTitleView = {[weak self] in
        
        //        屏幕的宽度 UIScreen.main.bounds.width
        let titleFrame = CGRect(x: 0, y: k状态栏的高度 + kNavigationBarH, width: kScreenW, height: kTitleH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    lazy var pageContentView:PageContentView = {[weak self] in
        //        1. 确定内容的frame
        let contentH = kScreenH - k状态栏的高度 - kNavigationBarH - kTitleH - kTabbarH
        let contentFrame = CGRect(x: 0, y:  k状态栏的高度 + kNavigationBarH + kTitleH, width: kScreenW, height: contentH)
        //        2. 确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        childVcs.append(GameViewController())
        for _ in 0..<2{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    
    //MARK: -   系统的回调函数
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

//MARK: -设置UI界面
extension HomeViewController{
    func setupUI(){
        //        不需要调整UIScollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        // 1. 设置导航栏
        setupNavigationBar()
        // 2.   添加TitlteView
        view.addSubview(pageTitleView)
        //        3.添加ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    
    private func setupNavigationBar(){
        //1.设置首页导航栏左侧 logo Item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2.    设置右侧的Item
        
        let size = CGSize(width: 40, height: 40) //更改 Item的的大小
        //        调用构造方法
        let historyItem = UIBarButtonItem(imageName: "history_btn_pk", highImageName: "", size: size)
        //       or 调用类方法
        //        let historyItem = UIBarButtonItem.createItem(imageName: "history_btn_pk", highImageName: "", size: size)
        
        let searchItem = UIBarButtonItem.createItem(imageName: "searchBtnIconHL", size: size)
        
        let  qrcodeItem = UIBarButtonItem.createItem(imageName: "scanIconHL", highImageName: "scanIconHL", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }
}
//MARK: - 遵守PageTitleViewDelegate协议
extension HomeViewController: PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: - 遵守PagecontentViewDelegate协议
extension HomeViewController : UIPageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
