//
//  TabBarController.swift
//  golden
//
//  Created by 张立 on 15/5/4.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

protocol ChangeTableDelegate{
    func changeIndex ( index: Int)
}

class TabBarController: UIViewController {
    //
    var  hotButton : UIButton!
    var  madeButton : UIButton!
    var  playButton : UIButton!
    var  chatButton : UIButton!
    var  userButton : UIButton!
    var  currentSelected:UIButton!
    
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        let w = view.frame.width
  
        initButton1(w)
        initButton2(w)
        initButton3(w)
        initButton4(w)
        initButton5(w)
        
        self.view.addSubview(hotButton)
        self.view.addSubview(madeButton)
        self.view.addSubview(playButton)
        self.view.addSubview(chatButton)
        self.view.addSubview(userButton)
        currentSelected = hotButton
        self.view.addSubview(currentSelected)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let w = view.frame.width
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
        blur.frame = CGRect(x: 0, y: 20, width: w, height: 70)//self.view.frame
        
        self.view.addSubview(blur)
        self.view.sendSubviewToBack(blur)

        
        
        
        //设置阴影颜色，透明度，偏移量
        self.view.layer.shadowColor = UIColor.grayColor().CGColor
        self.view.layer.shadowRadius = 2
        self.view.layer.shadowOpacity = 0.35;
        self.view.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    }
    
    func initButton1(width:CGFloat){
        
       
        
        hotButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        
        hotButton.frame = CGRect(x: width/6-48, y: 22, width: 50, height: 50)
        hotButton.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        hotButton.titleLabel?.frame = CGRect(x: 0, y: 30, width: 20, height: 20)
        hotButton.centerImageAndTitle(1)
       
        hotButton.setImage(UIImage(named: "tab_hot"), forState: UIControlState.Normal)
        hotButton.setImage(UIImage(named: "tab_hot_h"), forState: UIControlState.Selected)
        
        
        hotButton.addTarget(self, action: "changeTabBar:", forControlEvents: UIControlEvents.TouchUpInside)
        hotButton.setTitle("  热点", forState: UIControlState.Normal)
        hotButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        hotButton.setTitleColor(UIColor(rgb: 0xe50012), forState: UIControlState.Selected)
        hotButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        hotButton.titleLabel?.textAlignment = NSTextAlignment.Left

        hotButton.tag = 0
    }
    func initButton2(width:CGFloat){
        madeButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        madeButton.frame = CGRect(x: width/3-30, y: 22, width: 50, height: 50)
        madeButton.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        madeButton.titleLabel?.frame = CGRect(x: 0, y: 30, width: 20, height: 20)
        
        madeButton.centerImageAndTitle(1)
        
        madeButton.setImage(UIImage(named: "tab_group"), forState: UIControlState.Normal)
        madeButton.setImage(UIImage(named: "tab_group_h"), forState: UIControlState.Selected)
        madeButton.addTarget(self, action: "changeTabBar:", forControlEvents: UIControlEvents.TouchUpInside)
        
        madeButton.setTitle("定制圈", forState: UIControlState.Normal)
        madeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        madeButton.setTitleColor(UIColor(rgb: 0xe50012), forState: UIControlState.Selected)
        madeButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        madeButton.titleLabel?.textAlignment = NSTextAlignment.Left

        
        madeButton.tag = 1
    }
    func initButton3(width:CGFloat){
        playButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        playButton.frame = CGRect(x: width/2-25, y: 5, width: 50, height: 50)
        playButton.setBackgroundImage(UIImage(named: "tab_camera"), forState: UIControlState.Normal)
        playButton.setBackgroundImage(UIImage(named: "tab_camera"), forState: UIControlState.Selected)
        playButton.addTarget(self, action: "changeTabBar:", forControlEvents: UIControlEvents.TouchUpInside)
        playButton.tag = 2
    }
    func initButton4(width:CGFloat){
        chatButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        chatButton.frame = CGRect(x: width*4/6-10, y: 22, width: 50, height: 50)
        chatButton.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        chatButton.titleLabel?.frame = CGRect(x: 0, y: 30, width: 20, height: 20)
        chatButton.centerImageAndTitle(1)
        
        chatButton.setImage(UIImage(named: "tab_tips"), forState: UIControlState.Normal)
        chatButton.setImage(UIImage(named: "tab_tips_h"), forState: UIControlState.Selected)
        chatButton.addTarget(self, action: "changeTabBar:", forControlEvents: UIControlEvents.TouchUpInside)
        
        chatButton.setTitle(" 消息", forState: UIControlState.Normal)
        chatButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        chatButton.setTitleColor(UIColor(rgb: 0xe50012), forState: UIControlState.Selected)
        chatButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        chatButton.titleLabel?.textAlignment = NSTextAlignment.Center

        
        chatButton.tag = 3
    }
    
    func initButton5(width:CGFloat){
        userButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        userButton.frame = CGRect(x: width*5/6-4, y: 22, width: 50, height: 50)
        userButton.imageView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        userButton.titleLabel?.frame = CGRect(x: 0, y: 30, width: 20, height: 20)
        userButton.centerImageAndTitle(1)
        
        
        userButton.setImage(UIImage(named: "tab_user.png"), forState: UIControlState.Normal)
        userButton.setImage(UIImage(named: "tab_user_h.png"), forState: UIControlState.Selected)
        userButton.addTarget(self, action: "changeTabBar:", forControlEvents: UIControlEvents.TouchUpInside)
        
        userButton.setTitle("   我", forState: UIControlState.Normal)
        userButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        userButton.setTitleColor(UIColor(rgb: 0xe50012), forState: UIControlState.Selected)
        userButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        userButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        userButton.tag = 4
    }
    
    
    //
    var delegate : ChangeTableDelegate?
    
    func changeTabBar(sender : UIButton){
//        if(sender.tag < 5){
//            currentSelected.selected = false
//            if(sender.tag == 0){
//                currentSelected = hotButton
//            } else if(sender.tag == 1){
//                currentSelected = madeButton
//            } else if(sender.tag == 2){
//                currentSelected = playButton
//            } else if(sender.tag == 3){
//                currentSelected = chatButton
//            } else if(sender.tag == 4){
//                currentSelected = userButton
//            }
//            currentSelected.selected = true
//        }
        delegate?.changeIndex(sender.tag)
    }
}