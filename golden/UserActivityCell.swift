//
//  UserActivityCell.swift
//  golden
//
//  Created by 张立 on 15/5/6.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire
class UserActivityCell: UITableViewCell {

    
    let bgImageView:UIImageView!
    var request: Alamofire.Request?

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        var w=UIScreen.mainScreen().bounds.size.width
        bgImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: w-20, height: 160))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(bgImageView)
    }
    
    
    func setData(bgImage:UIImage){
        self.bgImageView.image = bgImage
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
