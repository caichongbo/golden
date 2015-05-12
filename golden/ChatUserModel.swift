//
//  ChatUserModel.swift
//  golden
//
//  Created by 蔡崇博 on 15/5/8.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

//用户消息单条明细
class ChatUserModel:NSObject{
    
    let senderName:String
    let senderImg:UIImage
    let sendMsg:String
    let sendTime:String
    
    init(senderName:String,senderImg:UIImage,sendMsg:String,sendTime:String) {
        self.senderName=senderName
        self.senderImg=senderImg
        self.sendMsg=sendMsg
        self.sendTime=sendTime
    }
    
}