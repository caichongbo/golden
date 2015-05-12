//
//  AlamofireUtil.swift
//  golden-laser
//
//  Created by 张立 on 15/4/30.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireUtil: NSObject {
   
 
    
    //更新用户信息
    func updateUser(url:String,parameters: [String : AnyObject]){
        Alamofire.request(.POST, url, parameters: parameters).responseJSON {
            (_,_,json,error) -> Void in
            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let j = json as? NSDictionary {
                    
                }
            })
            }
        }
    }
}
