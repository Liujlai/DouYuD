//
//  RecommendViewModel.swift
//  DYTV
//
//  Created by idea on 2017/8/9.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class RecommendViewModel{
    
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
    
    lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

//MARK: -发送网络请求
extension RecommendViewModel{
    func requestData(finishCallback : @escaping () ->()){
        //        定义参数
        let parameters = ["limit" : "4","offset":"0","time": NSDate.getCurrentTime() as NSString]
        //        创建Group
        let dGroup = DispatchGroup()
        //        1.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .get, parameters: ["time": NSDate.getCurrentTime() as NSString]) { (result) in
            //            1. 将result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else{ return }
            
            //            2. 根据data的key，获取数组
            guard let dataArray = resultDict["data"] as? [[String  : NSObject]] else{ return }
            //            3.  便利字典，并且转成模型对象
            //            3.1创建组
//            let group = AnchorGroup()
            //            3.2设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            //            3.3获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //            3.4离开组
            dGroup.leave()
            print("请求到第0组的数据")
        }
        
        //        2.请求第二部分的颜值数据
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .get, parameters: parameters) { (result) in
            //            1. 将result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else{ return }
            
            //            2. 根据data的key，获取数组
            guard let dataArray = resultDict["data"] as? [[String  : NSObject]] else{ return }
            //            3.  便利字典，并且转成模型对象
            //            3.1创建组
//            let group = AnchorGroup()
            //            3.2设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            //            3.3获取主播数据
            for dict in dataArray{
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            //        3.4离开组
            dGroup.leave()
            print("请求到1")
        }
        
        
        
        //        3.请求后面部分的游戏数据
        dGroup.enter()
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .get, parameters:parameters) { (result) in
            //            1. 将result 转成字典类型
            guard let resultDict = result as? [String : NSObject] else{ return }
            
            //            2. 根据data的key，获取数组
            guard let dataArray = resultDict["data"] as? [[String  : NSObject]] else{ return }
            
            //            3.遍历数组，获取字典，并将字典转成模型对象
            for dict in dataArray{
                let group = AnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            
            //            for group in self.anchorGroups{
            //                for anchor in group.anchors {
            //                    print(anchor.nickname)
            //                }
            //                print("-----------------")
            //            }
            //           4.离开组
            dGroup.leave()
            print("请求到2～12")
            
        }
        
        //         所有的数据都请求到，之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
//            队列组打印的顺序似乎🈶️点乱
//            print("所有数据都请求到")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
        
    }
}