//
//  TableViewCell.swift
//  golden-laser
//
//  Created by 张立 on 15/4/21.
//  Copyright (c) 2015年 张立. All rights reserved.
//



import UIKit

class TableViewCell:UITableViewCell{
    var customView:UIView!
    var bubbleImage:UIImageView!
    var avatarImage:UIImageView!
    var msgItem:MessageItem!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //- (void) setupInternalData
    init(data:MessageItem, reuseIdentifier cellId:String){
        self.msgItem = data
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier:cellId)
        rebuildUserInterface()
    }
    
    func rebuildUserInterface(){
        var w = UIScreen.mainScreen().bounds.size.width
        self.selectionStyle = UITableViewCellSelectionStyle.None
        if (self.bubbleImage == nil){
            self.bubbleImage = UIImageView()
            self.addSubview(self.bubbleImage)
        }
        
        self.backgroundColor = UIColor.clearColor()
        
        var type =  self.msgItem.mtype
        var width =  self.msgItem.view.frame.size.width
        
        var height =  self.msgItem.view.frame.size.height
        
        var x =  (type == ChatType.Someone) ? 0 : w - width - self.msgItem.insets.left - self.msgItem.insets.right
        
        var y:CGFloat =  0
        //if we have a chatUser show the avatar of the YDChatUser property
        if (self.msgItem.user.username != ""){
            
            var thisUser =  self.msgItem.user
            //self.avatarImage.removeFromSuperview()
            
            self.avatarImage = UIImageView(image:thisUser.avatar)
            
            
            
            self.avatarImage.layer.cornerRadius = 9.0
            self.avatarImage.layer.masksToBounds = true
            self.avatarImage.layer.borderColor = UIColor(white:0.0 ,alpha:0.2).CGColor
            self.avatarImage.layer.borderWidth = 1.0
            //calculate the x position
            
            var avatarX =  (type == ChatType.Someone) ? 15 : w - 65
            println("avata:\(height)")
            var avatarY =  height
            //set the frame correctly
            self.avatarImage.frame = CGRectMake(avatarX, avatarY, 50, 50)
            println(self.avatarImage.frame )
            self.addSubview(self.avatarImage)
            
            
            var delta =  self.frame.size.height - (self.msgItem.insets.top + self.msgItem.insets.bottom + self.msgItem.view.frame.size.height)
            println("delta:\(delta)")
            if (delta > 0)
            {
                y = delta
            }
            if (type == ChatType.Someone)
            {
                x += 72
            }
            if (type == ChatType.Mine)
            {
                x -= 72
            }
        }
        println("Y:\(y)")
        //self.customView.removeFromSuperview()
        
        self.customView = self.msgItem.view
        self.customView.frame = CGRectMake(x + self.msgItem.insets.left, y + self.msgItem.insets.top, width, height)
        
        //customView.backgroundColor = UIColor.darkGrayColor()
        
        self.addSubview(self.customView)
        
        //depending on the ChatType a bubble image on the left or right
        if (type == ChatType.Someone){
            self.bubbleImage.image = UIImage(named:("yoububble"))!.stretchableImageWithLeftCapWidth(21,topCapHeight:14)
            
        }else {
            self.bubbleImage.image = UIImage(named:"mebubble")!.stretchableImageWithLeftCapWidth(15, topCapHeight:14)
        }
        self.bubbleImage.frame = CGRectMake(x, y, width + self.msgItem.insets.left + self.msgItem.insets.right, height + self.msgItem.insets.top + self.msgItem.insets.bottom)
    }
}
