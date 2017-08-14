//
//  GameViewModel.swift
//  DYTV
//
//  Created by idea on 2017/8/12.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class GameViewModel {
//    创建数组来 保存模型
    lazy var game: [GameModel] = [GameModel]()

    
    
}


extension GameViewModel{
    func loadAllGameData(finishedCallBack :@escaping () -> ())  {
//        13:27~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        NetworkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", type: .get, parameters: ["shortName" : "game"]) { (result) in
            //1.获取到数据
            print(result)
//            转换成字典
            guard let resultDict = result as? [String:Any] else { return }
//            取出数组里存放的字典类型
            guard let dataArray = resultDict["data"] as? [[String:Any ]] else{ return }
            //2.字典转模型
            for dict in dataArray{
                self.game.append( GameModel(dict: dict))
            }
            //3.完成回调
            finishedCallBack()
        }
    }
}
