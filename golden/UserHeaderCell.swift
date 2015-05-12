//
//  UserHeaderCell.swift
//  golden-laser
//
//  Created by 张立 on 15/4/27.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {
    
    
    let img:UIImageView
    //let userName:UILabel
    let w:CGFloat
    

    //- (void) setupInternalData
    init(w:CGFloat, reuseIdentifier cellId:String){
        self.w = w
        img = UIImageView(frame:CGRectMake(10, 10, 80, 80))
//        userName = UILabel(frame: CGRectMake(10, 40, 60, 20))
//        userName.numberOfLines = 1
//        userName.textAlignment = NSTextAlignment.Left
//        userName.font = UIFont.boldSystemFontOfSize(12)
//        userName.tag = 100
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
       
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(img)
        //self.addSubview(userName)
        
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    
    func setData(img:UIImage,userName:String){
        println(userName)
        self.img.image = img
        //self.userName.text = userName
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
