//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by idea on 2017/8/15.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {


}
extension AmuseViewModel{
//    请求娱乐界面的数据
    func loadAmusedata(finishedCallback: @escaping () -> ()){
        
   loadAnchorData(URLString:  "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallBack: finishedCallback)
            }
    }
    
