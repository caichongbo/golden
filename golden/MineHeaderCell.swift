//
//  MineHeaderCell.swift
//  golden-laser
//
//  Created by 张立 on 15/4/23.
//  Copyright (c) 2015年 张立. All rights reserved.
//
//我头部cell
import UIKit
import Alamofire

class MineHeaderCell: UITableViewCell {
    
    let img:UIImageView
    let bgImg:UIImageView
    let userName:UILabel
    let userNote:UILabel
    var request: Alamofire.Request?

    
    init(w:CGFloat, reuseIdentifier cellId:String) {
        bgImg = UIImageView(frame:CGRectMake(0, 0, w, 120))
        img = UIImageView(frame:CGRectMake(10, 30, 60, 60))
        
        userName = UILabel(frame: CGRectMake(80, 35, 200, 30))
        userName.numberOfLines = 1
        userName.textAlignment = NSTextAlignment.Left
        userName.font = UIFont.boldSystemFontOfSize(14)
        userName.textColor = UIColor.whiteColor()
        userName.tag = 100
        
        userNote = UILabel(frame: CGRectMake(80, 70, 200, 40))
        userNote.numberOfLines = 2
        userNote.lineBreakMode  = NSLineBreakMode.ByTruncatingTail
        userNote.textAlignment = NSTextAlignment.Left
        userNote.textColor = UIColor.whiteColor()
        userNote.font = UIFont.systemFontOfSize(14)
        userNote.tag = 101
        
        
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: cellId)
        self.backgroundColor = UIColor.whiteColor()
        self.addSubview(bgImg)
        self.addSubview(img)
        self.addSubview(userName)
        self.addSubview(userNote)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
    }
    
    func setData(bgImg:UIImage,img:UIImage,userName:String,userNote:String){
        println(userName)
        self.bgImg.image = bgImg
        self.img.image = img
        self.userName.text = userName
        self.userNote.text = userNote
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
