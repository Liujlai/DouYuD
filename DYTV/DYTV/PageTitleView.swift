//
//  PageTitleView.swift
//  DYTV
//
//  Created by idea on 2017/8/4.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

private let kScrollLineH:CGFloat = 2

class PageTitleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //MARK: -定义属性
 var titles :[String]
    
    //MARK: -懒加载属性
    lazy var titleLables: [UILabel] = [UILabel]()
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
//        设置不超过范围
        scrollView.bounces = false
        return scrollView
    }()
    
    lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    
    //MARK: -自定义构造函数
    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK: - 设置UI界面
extension PageTitleView{
     func setupUI(){
//1.   添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
//2.     添加title对应的label
        setupTitleLabels()
//3.       设置底部的线条和滚动的滑块
        
        
    }
    
    private func setupTitleLabels(){
//        确定label的一些frame的值
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollLineH
        let labelY:CGFloat = 0
        for (index, title) in titles.enumerated() {
// 1.            创建UIlable
            let  label = UILabel()
// 2.           设置label的属性
            print(title)
            label.text = title
            label.tag = index
//            文字大小
            label.font = UIFont.systemFont(ofSize: 16.0)
//            文字颜色
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
//3.            设置label的frame---->才能使其显示出来
            setupBottonMenuAndScrollLine()
          
            let labelX:CGFloat = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
//4.             将lable添加到scrollView中
            scrollView.addSubview(label)
            titleLables.append(label)
            
        }
    }
    
    private func setupBottonMenuAndScrollLine(){
//       1. 添加底线
        let buttonLine = UIView()
        buttonLine.backgroundColor = UIColor.lightGray
        let lineH:CGFloat = 0.5
        
        buttonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        scrollView.addSubview(buttonLine)
//       2. 添加scrollLine
//        获取第一个label
        guard let firstLabel = titleLables.first else{ return }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
    
    
}
