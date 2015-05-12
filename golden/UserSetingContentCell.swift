//
//  UserSetingContentCell.swift
//  golden
//
//  Created by 张立 on 15/5/7.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserSetingContentCell: UITableViewCell {
    
    
    let label:UILabel!
    let bgImageView:UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        var w=UIScreen.mainScreen().bounds.size.width
        label = UILabel(frame: CGRectMake(10, 15, 200, 25))
        bgImageView = UIImageView(frame: CGRectMake(0, 54.5, w, 0.5))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.Left
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = UIColor.darkGrayColor()
        bgImageView.image = UIImage(named: "cutline-1")
        self.addSubview(label)
        self.addSubview(bgImageView)
        self.backgroundColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(labelContent:String){
        self.label.text = labelContent
    }

}
