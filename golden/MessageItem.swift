//
//  MessageItem.swift
//  golden-laser
//
//  Created by 张立 on 15/4/21.
//  Copyright (c) 2015年 张立. All rights reserved.
//


import UIKit

enum ChatType{
    case Mine
    case Someone
}

class MessageItem{
    
    var user:UserInfo
    var date:NSDate
    var mtype:ChatType
    var view:UIView
    var insets:UIEdgeInsets
    
    
    class func getTextInsetsMine() -> UIEdgeInsets{
        return UIEdgeInsets(top:5, left:10, bottom:11, right:17)
    }
    
    class func getTextInsetsSomeone() -> UIEdgeInsets{
        return UIEdgeInsets(top:5, left:15, bottom:11, right:10)
    }
    
    class func getImageInsetsMine() -> UIEdgeInsets{
        return UIEdgeInsets(top:11, left:13, bottom:16, right:22)
    }
    
    class func getImageInsetsSomeone() -> UIEdgeInsets{
        return UIEdgeInsets(top:11, left:13, bottom:16, right:22)
    }
    
   
    
    
    
    convenience init(body:String, user:UserInfo, date:NSDate, mtype:ChatType){
        var font =  UIFont.systemFontOfSize(14)
        
        //var w = view.frame.width
        
       var width =  175, height = 10000.0
       var atts =  NSMutableDictionary()
       atts.setObject(font,forKey:NSFontAttributeName)
        
       var size =  body.boundingRectWithSize(CGSizeMake(CGFloat(width), CGFloat(height)),options:NSStringDrawingOptions.UsesLineFragmentOrigin,  attributes: [NSFontAttributeName:font],context:nil)
        
        var label =  UILabel(frame:CGRectMake(0, 0, size.size.width, size.size.height))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.text = (!body.isEmpty ? body : "")
        label.font = font
        label.textColor = UIColor.darkGrayColor()
        label.backgroundColor = UIColor.clearColor()
        
        var insets:UIEdgeInsets =  (mtype == ChatType.Mine ? MessageItem.getTextInsetsMine() : MessageItem.getTextInsetsSomeone())
        
        self.init(user:user, date:date, mtype:mtype, view:label, insets:insets)
    }
    
    init(user:UserInfo, date:NSDate, mtype:ChatType, view:UIView, insets:UIEdgeInsets){
        self.view = view
        self.user = user
        self.date = date
        self.mtype = mtype
        self.insets = insets
    }
}