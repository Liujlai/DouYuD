//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by idea on 2017/8/15.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()

}
extension AmuseViewModel{
//    请求娱乐界面的数据
    func loadAmusedata(finishedCallback: @escaping () -> ()){
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", type: .get) { (result) in
//            对结果进行处理-->转成字典
            guard let resultDict = result as? [String: Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return}
//            便利数组中的字典
            for dict in dataArray{
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            //完成回调
            finishedCallback()
        }
    }
    
}
