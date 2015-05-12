//
//  ChatRootViewController.swift
//  golden
//
//  Created by 张立 on 15/5/4.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class ChatRootViewController: UIViewController,ChatSourceProtocol {
    
    var table:ChatMainView!
    var source:ChatPreViewModel!
    var users : NSMutableArray!
    
    
    //该导航需要设置的
    var NavigationController:UINavigationController!
    
    
    class func ChatInit()->UIViewController{
        var home = UIStoryboard(name: "chat", bundle: nil).instantiateInitialViewController() as! UIViewController
        return home
    }
    
    func addNavigationItemButton(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "searchClick")
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image:UIImage(named: "btn_add_user")!, style: UIBarButtonItemStyle.Plain, target: self, action: "inviteFrindsClick")
    }
    
    func searchClick(){
        println("点击search")
    }
    
    func inviteFrindsClick(){
         println("点击firend")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "消息"
        let w = self.view.frame.width
        view.backgroundColor = UIColor.whiteColor()
        
        self.table = ChatMainView(selfController:self,navigationController: self.navigationController!,frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        self.view.addSubview(table)
        
        // Do any additional setup after loading the view, typically from a nib.
        self.table!.registerClass(ChatUserNoticeCell.self, forCellReuseIdentifier: "ChatUserNoticeCell")    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadSheet() {
        //执行点击按钮时弹出对话框
        
    }
    
    
    func loadData() ->NSMutableArray{
        return users
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        
        users  = NSMutableArray()
        self.table.sourceProtocol = self
        
        if !document.haveLogin(){
            let minePageController = UserLoginViewController()
            minePageController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            rootController.presentViewController(minePageController,animated:true, completion:nil)
        }else{
            self.navigationController?.navigationBar.hidden =  false
            let back = UIBarButtonItem()
            back.title = ""
            self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
            self.navigationItem.backBarButtonItem = back
            addNavigationItemButton()
            rootController.showOrhideToolbar(true)
            
            
            //        var preUserMsgs = NSMutableArray()
            //        let chatUserModel =  ChatUserModel(senderName:"小明",senderImg:UIImage(named: "bg_personal")!,sendMsg:"你好，我是小明",sendTime:"2015-05-08")
            //        let chatUserModel2 =  ChatUserModel(senderName:"啊黄",senderImg:UIImage(named: "bg_personal")!,sendMsg:"你好，我是啊黄",sendTime:"2015-05-09")
            //        preUserMsgs.addObject(chatUserModel)
            //        preUserMsgs.addObject(chatUserModel2)
            //
            //        let lastSysMsg = "姚明已经关注了你，你们可以聊天了"
            //        source = ChatPreViewModel(lastSysMsg: lastSysMsg,preUserMsgs: preUserMsgs)
            
            
            users  = NSMutableArray()
            let resultDictionary = document.queryDataOfPlist(User_Plist)
            if resultDictionary.count != 0 {
                if let x  = resultDictionary.objectForKey("USER_ID") as? String{
                    if x == "1" {
                        users.addObjectsFromArray([UserInfo(id: "2", name: "龙泽大萝莉", logo: UIImage(named: "abaose")!),UserInfo(id: "3", name: "罗斌", logo: UIImage(named: "abaose")!),UserInfo(id: "4", name: "wqrw", logo: UIImage(named: "abaose")!),UserInfo(id: "5", name: "dshtr", logo: UIImage(named: "abaose")!)])
                    } else if x == "2"{
                        users.addObjectsFromArray([UserInfo(id: "1", name: "abc", logo: UIImage(named: "abaose")!),UserInfo(id: "3", name: "罗斌", logo: UIImage(named: "abaose")!),UserInfo(id: "4", name: "wqrw", logo: UIImage(named: "abaose")!),UserInfo(id: "5", name: "dshtr", logo: UIImage(named: "abaose")!)])
                    } else if x == "3"{
                        users.addObjectsFromArray([UserInfo(id: "1", name: "abc", logo: UIImage(named: "abaose")!),UserInfo(id: "2", name: "龙泽大萝莉", logo: UIImage(named: "abaose")!),UserInfo(id: "4", name: "wqrw", logo: UIImage(named: "abaose")!),UserInfo(id: "5", name: "dshtr", logo: UIImage(named: "abaose")!)])
                    }
                    else if x == "4"{
                        users.addObjectsFromArray([UserInfo(id: "1", name: "abc", logo: UIImage(named: "abaose")!),UserInfo(id: "2", name: "龙泽大萝莉", logo: UIImage(named: "abaose")!),UserInfo(id: "3", name: "罗斌", logo: UIImage(named: "abaose")!),UserInfo(id: "5", name: "dshtr", logo: UIImage(named: "abaose")!)])
                    }
                    else if x == "5"{
                        users.addObjectsFromArray([UserInfo(id: "1", name: "abc", logo: UIImage(named: "abaose")!),UserInfo(id: "2", name: "龙泽大萝莉", logo: UIImage(named: "abaose")!),UserInfo(id: "3", name: "罗斌", logo: UIImage(named: "abaose")!),UserInfo(id: "4", name: "wqrw", logo: UIImage(named: "abaose")!)])
                    }
                }
            }
            self.table.reloadData()
        }
    }
}
