//
//  UserTableView.swift
//  golden-laser
//
//  Created by 张立 on 15/4/27.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserTableView: UITableView,UITableViewDelegate, UITableViewDataSource {
    
    
    let w:CGFloat
    var title = ["昵称","性别","绑定手机","个性签名","更换背景"]
    var source:NSMutableArray!
    var mineSourceProtocol:UserSourceProtocol!
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController,frame:CGRect){
        self.w = frame.size.width
        self.navigationController = navigationController
        super.init(frame:frame,  style:UITableViewStyle.Grouped)
        self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.delegate = self
        self.dataSource = self
    }
    
    //设置section高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 4
    }
    //设置section高度
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 4
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        
        if self.source.count != 0{
            let mineModel  = self.source[0] as! UserMessageModel
            //暂时没有使用cell的重用功能
            if(section == 0){
                let headerCell = UserHeaderCell(w: w,reuseIdentifier:"userHeaderCell")
                    headerCell.setData(UIImage(named: mineModel.userHeaderUrl)!,userName: mineModel.userName)
                return headerCell
            }else if section == 1 {
                let leftLabel  =  self.title[row]
                var showText = ""
                let contentCell = UserContentCell(w:w,reuseIdentifier:"userContentCell")
                if row != 1 {
                    contentCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                }
                if row == 0 {
                    showText = mineModel.userName
                }else if row == 1 {
                    showText = mineModel.userSix
                    contentCell.selectionStyle = UITableViewCellSelectionStyle.None
                }else{
                    showText = mineModel.userTel
                }
                contentCell.setData(leftLabel,myContent:showText)
                return contentCell
            }else{
                let leftLabel  =  self.title[row+3]
                let contentCell = UserContentCell(w:w,reuseIdentifier:"userContentCell")
                contentCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                contentCell.setData(leftLabel,myContent:"")
                return contentCell
            }
        }
        else{
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "nilCell")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        if self.source.count != 0{
            
            let section:Int = indexPath.section
            let row:Int = indexPath.row
            
            println("点击的时第:"+"\(section)"+"组，第:"+"\(row)行")
            
            var mineModel:UserMessageModel = self.source[0] as! UserMessageModel
            
            if(section==0){
                mineSourceProtocol.loadSheet()
            }else if section == 1{
                if row == 0 {
                    let userMessageEditController = UserMessageUserNameEditController(source: mineModel,pageTitle:title[row])
                    self.navigationController.pushViewController(userMessageEditController, animated: true)
                } else if row == 2{
                    println("编辑电话")
                }
            }else {
                if row == 0 {
                    let userMessageUserNoteEditController = UserMessageUserNoteEditController(source: mineModel,pageTitle:title[row+3])
                    self.navigationController.pushViewController(userMessageUserNoteEditController, animated: true)
                }else{
                    println("更换背景")
                }
            }
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //指定有多少个分区(Section)，默认为1
    func numberOfSectionsInTableView(tableView:UITableView)->Int{
        return 3
    }
    
    
    override func reloadData() {
        source = mineSourceProtocol.loadData()
        super.reloadData()
    }
    
    //重新定义每一个cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        let hight:CGFloat
        if section == 0{
            hight = 100
        }else{
            hight = 55
        }
        return hight
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0{
            return 1
        }
        else if section == 1{
            return 3
        }else{
            return 2
        }
    }
}
