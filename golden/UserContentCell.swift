//
//  UserContentCell.swift
//  golden-laser
//
//  Created by 张立 on 15/4/27.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserContentCell: UITableViewCell {
    
    let myTitle:UILabel
    let myContent:UILabel
    let w:CGFloat
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(w:CGFloat, reuseIdentifier cellId:String){
        self.w = w
        myTitle = UILabel(frame: CGRectMake(10, 15, 100, 25))
        myTitle.numberOfLines = 1
        myTitle.textAlignment = NSTextAlignment.Left
        myTitle.font = UIFont.systemFontOfSize(15)
        myTitle.textColor = UIColor.darkGrayColor()
        
        myContent = UILabel(frame: CGRectMake(w-160, 15, 120, 25))
        myContent.numberOfLines = 1
        myContent.lineBreakMode  = NSLineBreakMode.ByTruncatingMiddle
        myContent.textAlignment = NSTextAlignment.Right
        myContent.font = UIFont.systemFontOfSize(15)
        myContent.textColor = UIColor.darkGrayColor()
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
        self.addSubview(myTitle)
        self.addSubview(myContent)
        self.backgroundColor = UIColor.whiteColor()
        
    }
    
    
    func setData(myTitle:String,myContent:String){
        self.myTitle.text = myTitle
        self.myContent.text = myContent
    }
}
