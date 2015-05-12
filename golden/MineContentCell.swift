//
//  MineContentCell.swift
//  golden-laser
//
//  Created by 张立 on 15/4/23.
//  Copyright (c) 2015年 张立. All rights reserved.
//
//我列表cell
import UIKit

class MineContentCell: UITableViewCell {
    
    let cellIcon:UIImageView
    let myTitle:UILabel
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        
        cellIcon = UIImageView(frame: CGRect(x: 10, y: 15, width: 25, height: 25))
        myTitle = UILabel(frame: CGRectMake(45, 15, 200, 25))
        myTitle.numberOfLines = 1
        myTitle.textAlignment = NSTextAlignment.Left
        myTitle.font = UIFont.systemFontOfSize(15)
        myTitle.textColor = UIColor.darkGrayColor()

        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        self.addSubview(cellIcon)
        self.addSubview(myTitle)
        self.backgroundColor = UIColor.whiteColor()
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    
    func setData(cellIconImg:UIImage,myTitle:String){
        self.cellIcon.image = cellIconImg
        self.myTitle.text = myTitle
    }
}
