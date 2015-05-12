//
//  MineSecendCellTableViewCell.swift
//  golden-laser
//
//  Created by 张立 on 15/5/2.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class MineSecendCellTableViewCell: UITableViewCell {
    
    let gzLabel:UILabel!
    let gzCountLabel:UILabel!
    let fsLabel:UILabel!
    let fsCountLabel:UILabel!
    let xhLabel:UILabel!
    let xhCountLabel:UILabel!
    let fgImg1:UIImageView!
    let fgImg2:UIImageView!
    
    let gzButton:UIButton!
    let fsButton:UIButton!
    let xhButton:UIButton!
    
    
    
    init(w:CGFloat, reuseIdentifier: String){
        
        
        gzButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        gzButton.frame =  CGRect(x: 0, y: 0, width: w/3, height: 45)
        gzButton.setTitle("", forState: UIControlState.Normal)
        
        fsButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        fsButton.frame =  CGRect(x: gzButton.frame.width+1, y: 0, width: w/3, height: 45)
        fsButton.setTitle("", forState: UIControlState.Normal)
        
        xhButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        xhButton.frame =  CGRect(x: gzButton.frame.width+fsButton.frame.width+2, y: 0, width: w-(gzButton.frame.width+fsButton.frame.width+2), height: 45)
        xhButton.setTitle("", forState: UIControlState.Normal)
        
        
        gzLabel = UILabel(frame:CGRectMake(w/6-40,10,40,25))
        gzLabel.text = "关注"
        gzLabel.numberOfLines = 1
        gzLabel.textAlignment = NSTextAlignment.Right
        gzLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        gzLabel.font = UIFont.systemFontOfSize(15)
        gzLabel.textColor = UIColor.darkGrayColor()
        
        
        gzCountLabel = UILabel(frame:CGRectMake(w/6+10,10,40,25))
        gzCountLabel.numberOfLines = 1
        gzCountLabel.textAlignment = NSTextAlignment.Left
        gzCountLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        gzCountLabel.font = UIFont.systemFontOfSize(15)
        gzCountLabel.textColor = UIColor.darkGrayColor()
        
        fsLabel = UILabel(frame:CGRectMake(w*3/6-40,10,40,25))
        fsLabel.text = "粉丝"
        fsLabel.numberOfLines = 1
        fsLabel.textAlignment = NSTextAlignment.Right
        fsLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        fsLabel.font = UIFont.systemFontOfSize(15)
        fsLabel.textColor = UIColor.darkGrayColor()
        
        
        fsCountLabel = UILabel(frame:CGRectMake(w*3/6+10,10,40,25))
        fsCountLabel.numberOfLines = 1
        fsCountLabel.textAlignment = NSTextAlignment.Left
        fsCountLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        fsCountLabel.font = UIFont.systemFontOfSize(15)
        fsCountLabel.textColor = UIColor.darkGrayColor()
        
        xhLabel = UILabel(frame:CGRectMake(w*5/6-40,10,40,25))
        xhLabel.text = "喜欢"
        xhLabel.numberOfLines = 1
        xhLabel.textAlignment = NSTextAlignment.Right
        xhLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        xhLabel.font = UIFont.systemFontOfSize(15)
        xhLabel.textColor = UIColor.darkGrayColor()
        
        xhCountLabel = UILabel(frame:CGRectMake(w*5/6+10,10,40,25))
        xhCountLabel.numberOfLines = 1
        xhCountLabel.textAlignment = NSTextAlignment.Left
        xhCountLabel.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        xhCountLabel.font = UIFont.systemFontOfSize(15)
        xhCountLabel.textColor = UIColor.darkGrayColor()
        
        fgImg1 = UIImageView(frame: CGRect(x: w/3, y: 10, width: 1, height: 25))
        fgImg1.image = UIImage(named: "cutline")
        
        fgImg2 = UIImageView(frame: CGRect(x: w*2/3, y: 10, width: 1, height: 25))
        fgImg2.image = UIImage(named: "cutline")
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.addSubview(gzButton)
        self.addSubview(fsButton)
        self.addSubview(xhButton)
        
        self.addSubview(gzLabel)
        self.addSubview(gzCountLabel)
        self.addSubview(fsLabel)
        self.addSubview(fsCountLabel)
        self.addSubview(xhLabel)
        self.addSubview(xhCountLabel)
        self.addSubview(fgImg1)
        self.addSubview(fgImg2)
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    
    func setData(gzCount:Int,fsCount:Int,xhCount:Int){
        self.gzCountLabel.text = String(gzCount)
        self.fsCountLabel.text = String(fsCount)
        self.xhCountLabel.text = String(xhCount)
    }
    
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
