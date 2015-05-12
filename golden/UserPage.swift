//
//  UserPage.swift
//  golden
//
//  Created by 张立 on 15/5/7.
//  Copyright (c) 2015年 张立. All rights reserved.
//  我的主页故事集

import UIKit

class UserPage: NSObject {
    
    let storyId:Int
    let imageUrl:String
    let storyType:Int
    
    init(storyId:Int,imageUrl:String,storyType:Int){
        self.storyId = storyId
        self.imageUrl = imageUrl
        self.storyType = storyType
    }
}
