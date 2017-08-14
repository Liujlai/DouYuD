//
//  AnchorGroup.swift
//  DYTV
//
//  Created by idea on 2017/8/9.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    //    该组中对应的房间信息
    var room_list : [[String:NSObject]]? {
        didSet{
            guard let room_list = room_list else { return }
            for dict  in room_list {
                anchors.append(AnchorModel(dict:dict))
            }
        }
    }
    

    //    组显示的图标
    var icon_name :String = "home_herder_normal"
    //    游戏对应的图标
//    var icon_url :String = ""
    //    定义主播的模型对象数组
    lazy var anchors: [AnchorModel] = [AnchorModel]()

    


    /**
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String: NSObject]] {
                for dict  in dataArray {
                    anchors.append(AnchorModel(dict:dict))
                }
            }
        }
    }
 */
}
