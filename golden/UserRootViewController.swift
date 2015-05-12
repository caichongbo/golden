//
//  MineController.swift
//  golden-laser
//
//  Created by 张立 on 15/4/23.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire

class UserRootViewController:UIViewController,UserSourceProtocol {
    
    
    var table:MineTableView!
    var source:NSMutableArray!
    
    
    class func UserInit()->UIViewController{
        var home = UIStoryboard(name: "user", bundle: nil).instantiateInitialViewController() as! UIViewController
        return home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的"
        navigationBarHeight = self.navigationController!.navigationBar.frame.height+20
        
        var w = view.frame.width
        var h = view.frame.height
        view.backgroundColor = UIColor.darkGrayColor()
        self.table = MineTableView(selfController:self,navigationController: self.navigationController!,frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.table.keyboardDismissMode = .Interactive
        //创建一个重用的单元格
        self.table!.registerClass(MineContentCell.self, forCellReuseIdentifier: "mineContentCell")
        view.addSubview(table)
    }
    
    func loadSheet() {
        //执行点击按钮时弹出对话框
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() ->NSMutableArray{
        return source
    }
    
    override func viewWillAppear(animated: Bool) {
        source = NSMutableArray()
        self.table.mineSourceProtocol = self
        
        if USERSETING_JUMPER == 1 {
            USERSETING_JUMPER = 0
            rootController.changeIndex(0)
        }else{
            if !document.haveLogin(){
                let minePageController = UserLoginViewController()
                minePageController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                rootController.presentViewController(minePageController,animated:true, completion:nil)
            }else{
                rootController.showOrhideToolbar(true)
                self.navigationController?.navigationBar.hidden =  false
                let back = UIBarButtonItem()
                back.title = ""
                self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
                self.navigationItem.backBarButtonItem = back
                //loadRemoteData()
                testSource()
            }
        }
    }
    
    func testSource(){
        let User =  MineModel(userId: 11, userName: "帅哥", userSix: "男", userTel: "18995533870", userNote: "我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥我是帅哥", userBgUrl: "http://d8.yihaodianimg.com/N06/M04/A4/1F/CgQIzVVG0siAYkTkAADtrN96bAQ24200.jpg", userHeaderUrl: "http://d6.yihaodianimg.com/N07/M00/8E/20/CgQIz1VHBwOAHL9HAADpUtZnpcY54900.jpg",userPersonBgUrl:"http://d6.yihaodianimg.com/N05/M0A/1B/6F/CgQI01VI51aAWWA4AAHR9Ibz0nc37700.jpg",userBgImage:UIImage(named: "bg_my")!,userHeadeImage:UIImage(named: "pic_head_big")!,userPersonBgImage:UIImage(named: "bg_personal")!,gzCount:11,fsCount:33,xhCount:45)
        source.addObject(User)
        self.table.reloadData()
    }
    
    
    func loadRemoteData(){
        
        let ids = "1"
        let po = "我时帅哥"
        
        Alamofire.request(.POST, "http://192.168.82.108/api/user/getUserInfo", parameters: ["params":"{'id':'1','po':\(po)}"]).responseJSON {
            (_,_,json,error) -> Void in
            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let j = json as? NSDictionary {
                    var msg: String = j.valueForKey("code") as! String
                    if(msg == "100"){
                        var ap:NSDictionary = j.valueForKey("body") as! NSDictionary
                        let ko = MineModel(userId: (ap["id"] as! Int), userName: ap["user_real_name"] as! String, userSix: ap["sex"] as! String, userTel: ap["mobile_phone"] as! String, userNote: ap["user_real_name"] as! String,userBgUrl: ap["background_url"] as! String, userHeaderUrl: ap["avatar"] as! String,userPersonBgUrl:ap["background_url"] as! String,userBgImage:UIImage(named: "bg_my")!,userHeadeImage:UIImage(named: "pic_head_big")!,userPersonBgImage:UIImage(named: "bg_personal")!,gzCount:11,fsCount:33,xhCount:45)
                        self.source.addObject(ko)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.table.reloadData()
                        })
                    }
                }
            })
            }
        }
    }
}
