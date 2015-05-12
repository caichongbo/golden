//
//  ChatSystemNoticeCell.swift
//  golden
//
//  Created by 蔡崇博 on 15/5/5.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class ChatUserNoticeCell : UITableViewCell  {
    
    
    let titleImg:UIImageView
    let titleName:UILabel
    let titleContent:UILabel
    let lastNoticeTime:UILabel
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
        titleImg = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
        
        titleName = UILabel(frame: CGRectMake(80, 10, 200, 25))
        titleName.numberOfLines = 1
        titleName.textAlignment = NSTextAlignment.Left
        titleName.font = UIFont.systemFontOfSize(17)
        titleName.textColor = UIColor.darkGrayColor()
        
        titleContent = UILabel(frame: CGRectMake(80, 45, 200, 25))
        titleContent.numberOfLines = 1
        titleContent.textAlignment = NSTextAlignment.Left
        titleContent.font = UIFont.systemFontOfSize(12)
        titleContent.textColor = UIColor.darkGrayColor()
        
        
        lastNoticeTime = UILabel(frame: CGRectMake(75, 25, 150, 25))
        lastNoticeTime.numberOfLines = 1
        lastNoticeTime.textAlignment = NSTextAlignment.Right
        lastNoticeTime.font = UIFont.systemFontOfSize(12)
        lastNoticeTime.textColor = UIColor.darkGrayColor()
        
    
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(titleImg)
        self.addSubview(titleName)
        self.addSubview(titleContent)
        //self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(titleImg:UIImage,titleName:String,titleContent:String,lastNoticeTime:String){
       
        self.titleImg.image = titleImg
        self.titleName.text = titleName
        self.titleContent.text = titleContent
        self.lastNoticeTime.text = lastNoticeTime
    }
    
  
    
}
