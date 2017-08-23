//
//  BaseViewModel.swift
//  DYTV
//
//  Created by idea on 2017/8/16.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class BaseViewModel {
    
    
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel{
//    
    func loadAnchorData(isGroupData : Bool, URLString: String ,parameters : [String : Any]?  = nil , finishedCallBack :  @escaping () -> ()  ){
        NetworkTools.requestData(URLString: URLString, type: .get , parameters: parameters as? [String : NSString]) { (result) in
            //            对结果进行处理-->转成字典
            guard let resultDict = result as? [String: Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return}
           
            if isGroupData{
                //            便利数组中的字典
                for dict in dataArray{
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            }else{
//                创建组
                let group = AnchorGroup()
                
//                遍历dataArray的所有的字典
                for dict in dataArray{
                    group.anchors.append(AnchorModel(dict : dict))
                }
//                 将group。添加到anchorGroup
                self.anchorGroups.append(group)
                
            }
            
            //完成回调
            finishedCallBack()
        }
    }
}
