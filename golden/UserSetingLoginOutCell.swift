//
//  UserSetingLoginOutCell.swift
//  golden
//
//  Created by 张立 on 15/5/7.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserSetingLoginOutCell: UITableViewCell {
    
    let bgImageView:UIImageView!
    let label:UILabel!
    
    init(reuseIdentifier: String?){
    
        var w=UIScreen.mainScreen().bounds.size.width
        bgImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: w-20, height: 55))
        label = UILabel(frame: CGRectMake(0, 20, w, 25))
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)

        label.numberOfLines = 1
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(15)
        label.textColor = UIColor.whiteColor()
        
        self.addSubview(bgImageView)
        self.addSubview(label)
        self.backgroundColor = UIColor(rgb: 0xf3f4f6)
    }
    
    func setData(bgImage:UIImage,labelText:String){
        bgImageView.image = bgImage
        label.text = labelText
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
