//
//  UserMessageModel.swift
//  golden-laser
//
//  Created by 张立 on 15/4/27.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserMessageModel: NSObject {
    
    let userId:Int
    let userName:String
    let userSix:String
    let userTel:String
    let userNote:String
    let userBgUrl:String
    let userHeaderUrl:String
    
    init(userId:Int,userName:String,userSix:String,userTel:String,userNote:String,userBgUrl:String,userHeaderUrl:String){
        self.userId=userId
        self.userName=userName
        self.userSix=userSix
        self.userTel=userTel
        self.userNote=userNote
        self.userBgUrl=userBgUrl
        self.userHeaderUrl=userHeaderUrl
    }
}
