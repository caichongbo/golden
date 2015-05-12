//
//  ChatPerView.swift
//  golden
//
//  Created by 蔡崇博 on 15/5/9.
//  Copyright (c) 2015年 张立. All rights reserved.
//

//  用户消息总揽

import UIKit

class ChatPreViewModel{
    
    
    let lastSysMsg:String
    let preUserMsgs:NSMutableArray
    
    init(lastSysMsg:String,preUserMsgs:NSMutableArray){
        self.lastSysMsg=lastSysMsg
        self.preUserMsgs=preUserMsgs
        
    }
}
