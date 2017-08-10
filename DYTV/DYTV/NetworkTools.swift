//
//  NetworkTools.swift
//  alamofireDD
//
//  Created by idea on 2017/8/9.
//  Copyright © 2017年 idea. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case get
    case post
}

class NetworkTools{
    
    class func requestData(URLString :String,type:MethodType,parameters:[String:NSString]? = nil,finishedCallBack :@escaping (_ result:AnyObject) ->()){
        //       1. 获取类型
        let method = type == .post ? HTTPMethod.post : HTTPMethod.get
        //        2.发送网络请求
        Alamofire.request(URLString,method:method,parameters: parameters).responseJSON{(response) in
            //            3.获取结果
            guard let result = response.result.value else{
                print(response.result.error ?? "")
                return
            }
            //            4.将结果回调出去
            finishedCallBack(result as AnyObject)
        }
        
    }
}
