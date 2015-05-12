//
//  RootViewController.swift
//  smartmixer
//
//  Created by kingzhang on 8/24/14.
//  Copyright (c) 2014 Smart Group. All rights reserved.
//

import UIKit

//@MARK:一些用得着的静态变量
//这个是基础的控制类
var rootController:RootController!


let appID:String = "923816796"
//
let itunesLink:String="https://itunes.apple.com/cn/app/ji-wei-jiu-pro/id923816796?mt=8"

//设备类型
var deviceDefine:String="_ipad"
//系统版本
var osVersion:Double=8.0

class RootController: UITabBarController,ChangeTableDelegate{
    
    //欢迎页的控件
    var welcome:UIViewController!
    //自定义的Tabbar
    var mytabBar:TabBarController!
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone){
            deviceDefine = ""
        }
        osVersion = NSString(string: UIDevice.currentDevice().systemVersion).doubleValue
        
        //方便调用的全局变量
        rootController = self
        
        //初始化各个部分

        var hot =  HotRootViewController.HotInit()
        var made = MadeRootViewController.MadeInit()
        var play = PlayRootViewController.PlayInit()
        var chat = ChatRootViewController.ChatInit()
        var user = UserRootViewController.UserInit()
        
        var tabBarViewControllers = [hot,made,play,chat,user]
        self.setViewControllers(tabBarViewControllers, animated: false)
        
        //处理的自定义Toolbar
        self.tabBar.hidden = true;
        mytabBar = TabBarController()
        mytabBar.delegate = self
        mytabBar.view.frame = CGRect(x: 0, y: self.view.frame.size.height - 70 , width: self.view.frame.size.width, height: 70)
        self.view.addSubview(mytabBar.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad && osVersion<8){//iPad,IOS7的bug
            mytabBar.view.frame = CGRect(x: 0, y: self.view.frame.size.width - 70 , width: self.view.frame.size.height, height: 70)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //@MARK:控制下端Toolbar的代码
    var toolbarHidden:Bool=true
    //显示或影藏工具栏
    func showOrhideToolbar(opt:Bool){
        if(toolbarHidden != opt){
            toolbarHidden=opt
            if(opt){//显示
                self.mytabBar.view.hidden = false
                UIView.animateWithDuration(0.3, animations: {
                    if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad && osVersion<8){
                        self.mytabBar.view.frame = CGRect(x: 0, y: self.view.frame.size.width - 70 , width: self.view.frame.size.height, height: 70)
                    }else{
                        self.mytabBar.view.frame = CGRect(x: 0, y: self.view.frame.size.height - 70 , width: self.view.frame.size.width, height: 70)
                    }
                })
            }else{//隐藏
                UIView.animateWithDuration(0.3, animations: {
                    if(UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad && osVersion<8){
                        self.mytabBar.view.frame = CGRect(x: 0, y: self.view.frame.size.width, width: self.view.frame.size.height, height: 70)
                    }else{
                        self.mytabBar.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: 70)
                    }
                    }, completion: { _ in
                        self.mytabBar.view.hidden = true
                })
            }
            
        }
    }
    
    //@MARK:点击下端的按钮时的反馈调用
    func changeIndex(index: Int) {
        mytabBar.currentSelected.selected = false
        switch index{
        case 0:
            mytabBar.currentSelected = mytabBar.hotButton
            break
        case 1:
            mytabBar.currentSelected = mytabBar.madeButton
            break
        case 2:
            mytabBar.currentSelected = mytabBar.playButton
            break
        case 3:
            mytabBar.currentSelected = mytabBar.chatButton
            break
        case 4:
            mytabBar.currentSelected = mytabBar.userButton
            break
        default:
            break
        }
        mytabBar.currentSelected.selected = true
        self.selectedIndex = index
    }
}
