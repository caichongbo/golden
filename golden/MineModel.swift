//
//  MineModel.swift
//  golden-laser
//
//  Created by 张立 on 15/4/24.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class MineModel: NSObject {
    
    
    let userId:Int
    let userName:String
    let userSix:String
    let userTel:String
    let userNote:String
    let userBgUrl:String
    let userHeaderUrl:String
    let userPersonBgUrl:String
    let userBgImage:UIImage
    let userHeadeImage:UIImage
    let userPersonBgImage:UIImage
    let gzCount:Int
    let fsCount:Int
    let xhCount:Int
    
    
    init(userId:Int,userName:String,userSix:String,userTel:String,userNote:String,userBgUrl:String,userHeaderUrl:String,userPersonBgUrl:String,userBgImage:UIImage,userHeadeImage:UIImage,userPersonBgImage:UIImage,gzCount:Int,fsCount:Int,xhCount:Int){
        self.userId=userId
        self.userName=userName
        self.userSix=userSix
        self.userTel=userTel
        self.userNote=userNote
        self.userBgUrl=userBgUrl
        self.userHeaderUrl=userHeaderUrl
        self.gzCount=gzCount
        self.fsCount=fsCount
        self.xhCount=xhCount
        self.userBgImage=userBgImage
        self.userHeadeImage=userHeadeImage
        self.userPersonBgUrl=userPersonBgUrl
        self.userPersonBgImage=userPersonBgImage
    }
}
