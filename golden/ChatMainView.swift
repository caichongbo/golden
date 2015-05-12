//
//  ChatMainView.swift
//  golden
//
//  Created by 蔡崇博 on 15/5/5.
//  Copyright (c) 2015年 张立.  All rights reserved.
//

import UIKit

class ChatMainView :UITableView,UITableViewDelegate, UITableViewDataSource {
    
    let w:CGFloat
    //var source:ChatPreViewModel!
    var sourceProtocol:ChatSourceProtocol!
    var navigationController: UINavigationController
    var selfController:ChatRootViewController
    var users : NSMutableArray!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(selfController:ChatRootViewController,navigationController: UINavigationController,frame:CGRect){
        self.w = frame.size.width
        self.navigationController = navigationController
        self.selfController = selfController
        super.init(frame:frame,  style:UITableViewStyle.Grouped)
        self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.delegate = self
        self.dataSource = self
    }
    
    
    
    //指定有多少个分区(Section)， 2
    func numberOfSectionsInTableView(tableView:UITableView)->Int{
        return 2
    }
    //设置section高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let x = users {
            if section == 0{
                return 1
            }
            else{
                return users.count
            }
        }
        return 0
    }
    
    override func reloadData() {
        users = sourceProtocol.loadData()
        super.reloadData()
    }
    
    //重新定义每一个cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        
        
        
        if let x = users {
            if section == 0{
                let titleImg =  UIImage(named: "img_volume")
                let titleName = "系统通知"
                //let titleContent = source.lastSysMsg
                let identiString = "Cell"
                var contentCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: identiString)
                contentCell.textLabel?.text = titleName
                contentCell.imageView?.image = titleImg
                //contentCell.detailTextLabel?.text = "姚明已经关注了你，你们可以聊天了"
                contentCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                return contentCell
            }else{
                let suer = users[row] as! UserInfo
                var contentCell = tableView.dequeueReusableCellWithIdentifier("ChatUserNoticeCell", forIndexPath: indexPath) as? ChatUserNoticeCell
                contentCell?.setData(suer.avatar, titleName: suer.username, titleContent: "", lastNoticeTime: "")
                return contentCell!
            }
        } else {
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "nilCell")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        
        println("点击的时第:"+"\(section)"+"组，第:"+"\(row)行")
        if section==1 {
            let resultDictionary = document.queryDataOfPlist(User_Plist)
            let x  = resultDictionary.objectForKey("USER_ID") as? String
            let mex = UserInfo(id: x!, name: "hello", logo: UIImage(named: "xiaohei")!)
            let you  = users[row] as! UserInfo
            let userMessageEditController = ChatViewController(me: mex, you: you)
            self.navigationController.pushViewController(userMessageEditController, animated: true)
        }
    }
}