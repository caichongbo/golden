//
//  UserActivity.swift
//  golden
//
//  Created by 张立 on 15/5/6.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserActivity: NSObject {
    
    let userId:Int
    let activityWebUrl:String
    let activityBgImageUrl:String
    let activityBgImage:UIImage
    let activityTitle:String
    let activityCount:Int
    let pageSize:Int
    let currentPage:Int
    
    
    init(userId:Int,activityWebUrl:String,activityBgImageUrl:String,activityBgImage:UIImage,activityTitle:String,activityCount:Int,pageSize:Int,currentPage:Int){
        self.userId = userId
        self.activityWebUrl = activityWebUrl
        self.activityBgImageUrl = activityBgImageUrl
        self.activityBgImage = activityBgImage
        self.activityTitle = activityTitle
        self.activityCount = activityCount
        self.pageSize = pageSize
        self.currentPage = currentPage
    }
}
