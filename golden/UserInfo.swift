//
//  UserInfo.swift
//  golden-laser
//
//  Created by 张立 on 15/4/21.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import Foundation



/*
用户信息类
*/
class UserInfo:NSObject{
    let userid:String
    let username:String
    var avatar:UIImage
    
    init(id:String,name:String, logo:UIImage){
        self.userid = id
        self.username = name
        self.avatar = logo
    }
}