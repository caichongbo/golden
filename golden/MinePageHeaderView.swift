//
//  MineScrollHeaderView.swift
//  golden-laser
//
//  Created by 张立 on 15/5/4.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class MinePageHeaderView: UICollectionReusableView {

    
    let userName:UILabel!
    let userNote:UILabel!
    let bgImageView:UIImageView!
    let headImageView:UIImageView!
    let kkImageView:UIImageView!
    
    let gzLabel:UILabel!
    let gzCountLabel:UILabel!
    let fsLabel:UILabel!
    let fsCountLabel:UILabel!
    let xhLabel:UILabel!
    let xhCountLabel:UILabel!
    let fgImg1:UIImageView!
    let fgImg2:UIImageView!
    
    let bg1:UIView!
    let bg2:UIView!
    let bg3:UIView!
    
    let collectionTitle:UILabel!
   
    override init(frame: CGRect) {
        bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 282))
        headImageView = UIImageView(frame: CGRect(x: frame.width/2-50, y: bgImageView.frame.height/2-60, width: 100, height: 100))
        kkImageView = UIImageView(frame: CGRect(x: frame.width/2-51, y: bgImageView.frame.height/2-61, width: 102, height: 102))
        kkImageView.image =  UIImage(named:"head_border")
        
        userName = UILabel(frame: CGRectMake(frame.width/2-40,kkImageView.frame.maxY+10,80,30))
        userName.numberOfLines = 1
        userName.textAlignment = NSTextAlignment.Center
        userName.font = UIFont.systemFontOfSize(14)
        userName.textColor = UIColor.whiteColor()
        
        userNote = UILabel(frame:CGRectMake(20,userName.frame.maxY+10,frame.width-40,50))
        userNote.numberOfLines = 3
        userNote.textAlignment = NSTextAlignment.Left
        userNote.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        userNote.font = UIFont.systemFontOfSize(12)
        userNote.textColor = UIColor.whiteColor()
        
        
        bg1 = UIView(frame: CGRect(x: 0, y: bgImageView.frame.maxY, width: frame.width, height: 45))
        bg2 = UIView(frame: CGRect(x: 0, y: bg1.frame.maxY, width: frame.width, height: 10))
        bg2.backgroundColor = UIColor(rgb: 0xf3f4f6)
        bg3 = UIView(frame: CGRect(x: 0, y: bg2.frame.maxY, width: frame.width, height: 48))
        
        gzLabel = UILabel(frame:CGRectMake(frame.width/6-40,10,40,25))
        gzLabel.text = "关注"
        gzLabel.numberOfLines = 1
        gzLabel.textAlignment = NSTextAlignment.Right
        gzLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        gzLabel.font = UIFont.systemFontOfSize(15)
        gzLabel.textColor = UIColor.darkGrayColor()
        
        
        gzCountLabel = UILabel(frame:CGRectMake(frame.width/6+10,10,40,25))
        gzCountLabel.numberOfLines = 1
        gzCountLabel.textAlignment = NSTextAlignment.Left
        gzCountLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        gzCountLabel.font = UIFont.systemFontOfSize(15)
        gzCountLabel.textColor = UIColor.darkGrayColor()
        
        fsLabel = UILabel(frame:CGRectMake(frame.width*3/6-40,10,40,25))
        fsLabel.text = "粉丝"
        fsLabel.numberOfLines = 1
        fsLabel.textAlignment = NSTextAlignment.Right
        fsLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        fsLabel.font = UIFont.systemFontOfSize(15)
        fsLabel.textColor = UIColor.darkGrayColor()
        
        
        fsCountLabel = UILabel(frame:CGRectMake(frame.width*3/6+10,10,40,25))
        fsCountLabel.numberOfLines = 1
        fsCountLabel.textAlignment = NSTextAlignment.Left
        fsCountLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        fsCountLabel.font = UIFont.systemFontOfSize(15)
        fsCountLabel.textColor = UIColor.darkGrayColor()
        
        xhLabel = UILabel(frame:CGRectMake(frame.width*5/6-40,10,40,25))
        xhLabel.text = "喜欢"
        xhLabel.numberOfLines = 1
        xhLabel.textAlignment = NSTextAlignment.Right
        xhLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        xhLabel.font = UIFont.systemFontOfSize(15)
        xhLabel.textColor = UIColor.darkGrayColor()
        
        xhCountLabel = UILabel(frame:CGRectMake(frame.width*5/6+10,10,40,25))
        xhCountLabel.numberOfLines = 1
        xhCountLabel.textAlignment = NSTextAlignment.Left
        xhCountLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        xhCountLabel.font = UIFont.systemFontOfSize(15)
        xhCountLabel.textColor = UIColor.darkGrayColor()
        
        fgImg1 = UIImageView(frame: CGRect(x: frame.width/3, y: 10, width: 1, height: 25))
        fgImg1.image = UIImage(named: "cutline")
        
        fgImg2 = UIImageView(frame: CGRect(x: frame.width*2/3, y: 10, width: 1, height: 25))
        fgImg2.image = UIImage(named: "cutline")

        collectionTitle = UILabel(frame: CGRectMake(0,0,frame.width,48))
        collectionTitle.numberOfLines = 1
        collectionTitle.textAlignment = NSTextAlignment.Center
        collectionTitle.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        collectionTitle.font = UIFont.systemFontOfSize(17)
        collectionTitle.text = "我的故事集"
        
        
        
        super.init(frame: frame)
        self.addSubview(bgImageView)
        self.addSubview(headImageView)
        self.addSubview(kkImageView)
        self.addSubview(userName)
        self.addSubview(userNote)
        self.addSubview(bg1)
        self.addSubview(bg2)
        self.addSubview(bg3)
        
        bg3.addSubview(collectionTitle)
        
        
        bg1.addSubview(gzLabel)
        bg1.addSubview(gzCountLabel)
        bg1.addSubview(fsLabel)
        bg1.addSubview(fsCountLabel)
        bg1.addSubview(xhLabel)
        bg1.addSubview(xhCountLabel)
        bg1.addSubview(fgImg1)
        bg1.addSubview(fgImg2)
        
    }
    
    
    func setData(userNameString:String,userNoteString:String,bgImage:UIImage,headImage:UIImage,gzCount:Int,fsCount:Int,xhCount:Int){
        self.userName.text = userNameString
        self.userNote.text = userNoteString
        self.bgImageView.image = bgImage
        self.headImageView.image = headImage
        self.gzCountLabel.text = String(gzCount)
        self.fsCountLabel.text = String(fsCount)
        self.xhCountLabel.text = String(xhCount)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
