//
//  MineTableView.swift
//  golden-laser
//
//  Created by 张立 on 15/4/23.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire

class MineTableView: UITableView,UITableViewDelegate, UITableViewDataSource {
    
    
    let w:CGFloat
    var source:NSMutableArray!
    var mineSourceProtocol:UserSourceProtocol!
    var navigationController: UINavigationController
    var selfController:UserRootViewController
    var myTitle = ["我的主页","我的活动","设置","反馈"]
    var titlePic = ["my_home","my_activity","my_set","my_feedback"]
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(selfController:UserRootViewController,navigationController: UINavigationController,frame:CGRect){
        self.w = frame.size.width
        self.navigationController = navigationController
        self.selfController = selfController
        super.init(frame:frame,  style:UITableViewStyle.Grouped)
        self.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        self.delegate = self
        self.dataSource = self
    }
    
    override func reloadData() {
        source = mineSourceProtocol.loadData()
        super.reloadData()
    }
    
    
    //指定有多少个分区(Section)，默认为1
    func numberOfSectionsInTableView(tableView:UITableView)->Int{
        return 3
    }
    
    //重新定义每一个cell的高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        let hight:CGFloat
        if section==0{
            if row == 0{
                hight = 120
            }
            else{
                hight = 45
            }
        }else{
            hight = 55
        }
        return hight
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if section == 0{
            return 2
        }
        else if section == 1{
            return 2
        }
        else{
            return 2
        }
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
            if section == 0{
                let mineModel  = self.source[0] as! MineModel
                if row==0{
                    let headerCell = MineHeaderCell(w: w, reuseIdentifier: "mineHeaderCell")
//                    let bgPath = document.queryImageUrl(mineModel.userBgUrl)
//                    let headerPath = document.queryImageUrl(mineModel.userHeaderUrl)
//                    if bgPath != nil && headerPath != nil {
//                        headerCell.setData(UIImage(contentsOfFile: bgPath)!, img: UIImage(contentsOfFile: headerPath)!, userName: mineModel.userName, userNote: mineModel.userNote)
//                    }else{
//                        headerCell.bgImg.image = nil
//                        headerCell.request = Alamofire.request(.GET,mineModel.userBgUrl).response{(req,_,data,error) -> Void in
//                            if let d = data as? NSData{
//                                if error == nil{
//                                    let userBgImage  = UIImage(data:d)!
//                                    document.saveImageToDocumentAndPlist(mineModel.userBgUrl,imageData:d)
//                                    if req.URLString == headerCell.request?.request.URLString{
//                                        Alamofire.request(.GET,mineModel.userHeaderUrl).response{(req2,_,data2,error) -> Void in
//                                            if let d = data2 as? NSData{
//                                                if error == nil{
//                                                    headerCell.setData(userBgImage, img: UIImage(data:d)!, userName: mineModel.userName, userNote: mineModel.userNote)
//                                                    document.saveImageToDocumentAndPlist(mineModel.userHeaderUrl,imageData:d)
//                                                }
//                                            }
//                                        }
//                                    }
//                                }}
//                        }
//                    }
                    
                    headerCell.setData(mineModel.userBgImage, img: mineModel.userHeadeImage, userName: mineModel.userName, userNote: mineModel.userNote)
                    
                    return headerCell
                }else{
                    let secendCell = MineSecendCellTableViewCell(w: w, reuseIdentifier: "mineSecendCellTableViewCell")
                    secendCell.setData(mineModel.gzCount,fsCount:mineModel.fsCount,xhCount:mineModel.xhCount)
                    
                    secendCell.gzButton.addTarget(self, action: "gzButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
                    secendCell.fsButton.addTarget(self, action: "fsButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
                    secendCell.xhButton.addTarget(self, action: "xhButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
                    
                    secendCell.gzButton.tag = row + 1
                    secendCell.fsButton.tag = row + 2
                    secendCell.xhButton.tag = row + 3
                    
                    return secendCell
                }
            }else if section == 1{
                let cellIcon = UIImage(named: titlePic[row])
                let cellText = myTitle[row]
                var contentCell = tableView.dequeueReusableCellWithIdentifier("mineContentCell", forIndexPath: indexPath) as? MineContentCell
                contentCell!.setData(cellIcon!, myTitle: cellText)
                return contentCell!
            }else{
                let cellIcon = UIImage(named: titlePic[row+2])
                let cellText = myTitle[row+2]
                var contentCell = tableView.dequeueReusableCellWithIdentifier("mineContentCell", forIndexPath: indexPath) as? MineContentCell
                contentCell!.setData(cellIcon!, myTitle: cellText)
                return contentCell!
            }
        }
        else{
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "nilCell")
        }
    }
    
    func gzButtonClick(){
        println("点击关注")
        let userActivityViewController = UserActivityViewController(source: self.source)
        navigationController.pushViewController(userActivityViewController,animated:true)
    }
    
    func fsButtonClick(){
        println("点击粉丝")
    }
    
    func xhButtonClick(){
        println("点击喜欢")
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        
        println("点击的时第:"+"\(section)"+"组，第:"+"\(row)行")
        if section==0 {
            if row == 0{
                let userMessageController = UserMessageController(userId:11)
                navigationController.pushViewController(userMessageController, animated: true)
            }
        }else if section == 1 {
            if row == 0 {
                let minePageController = MinePageViewController(source: self.source)
                minePageController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                selfController.presentViewController(minePageController,animated:true, completion:nil)
            }else if row == 1{
                let userActivityViewController = UserActivityViewController(source: self.source)
                navigationController.pushViewController(userActivityViewController,animated:true)
            }else{
                
            }
        }else{
            if row == 0 {
                let userSetingViewController =  UserSetingViewController()
                navigationController.pushViewController(userSetingViewController, animated: true)
            }
        }
    }
}
