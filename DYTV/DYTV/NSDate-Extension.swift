//
//  NSDate-Extension.swift
//  DYTV
//
//  Created by idea on 2017/8/9.
//  Copyright © 2017年 idea. All rights reserved.
//

import Foundation

extension NSDate{
    
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = nowDate.timeIntervalSince1970
        
        return "\(interval)"
    }
}
