//
//  UserActivityViewController.swift
//  golden
//
//  Created by 张立 on 15/5/6.
//  Copyright (c) 2015年 张立. All rights reserved.
// 我的活动

import UIKit
import Alamofire

class UserActivityViewController: UITableViewController{
    
    var source:NSMutableArray!
    var activitys:NSMutableArray!
    let user:MineModel!
    
    init(source:NSMutableArray) {
        self.source = source
        user = self.source[0] as! MineModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的活动"
        self.tableView.registerClass(UserActivityCell.self, forCellReuseIdentifier: "UserActivityCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新")
        refreshControl.addTarget(self, action: "testSource", forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    override func viewWillAppear(animated: Bool) {
        rootController.showOrhideToolbar(false)
        if(animated){
            activitys = NSMutableArray()
            testSource()
            //loadRemoteData()
        }
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        var contentCell = tableView.dequeueReusableCellWithIdentifier("UserActivityCell", forIndexPath: indexPath) as? UserActivityCell
        let asp = activitys[row] as! UserActivity
        let filePath = document.queryImageUrl(asp.activityBgImageUrl)
        if filePath != nil {
            contentCell!.setData(UIImage(contentsOfFile: filePath)!)
        }else{
            contentCell!.bgImageView.image = nil
            contentCell!.request = Alamofire.request(.GET,asp.activityBgImageUrl).response{(req,_,data,error) -> Void in
                if let d = data as? NSData{
                    if error == nil{
                        if req.URLString == contentCell!.request?.request.URLString{
                            contentCell!.setData(UIImage(data: d)!)
                            document.saveImageToDocumentAndPlist(asp.activityBgImageUrl,imageData:d)
                        }
                    }
                }
            }
        }
        //contentCell!.setData(asp.activityBgImage)
        return contentCell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        println("点击的时第:"+"\(section)"+"组，第:"+"\(row)行")
    }
    
    
    func testSource(){
        activitys = []
        self.refreshControl?.beginRefreshing()
        let sp1 = UserActivity(userId: self.user.userId, activityWebUrl: "", activityBgImageUrl: "http://d6.yihaodianimg.com/N06/M07/B8/A6/CgQIzVVK4Z2AdT8dAAH3OBjhqac56400.jpg", activityBgImage: UIImage(named: "bg_my")!, activityTitle: "我的第一个活动", activityCount: 20, pageSize: 30, currentPage: 1)
        let sp2 = UserActivity(userId: self.user.userId, activityWebUrl: "", activityBgImageUrl: "http://d6.yihaodianimg.com/N05/M03/26/8D/CgQI01VK4euAc08DAAE4pgLJiCA93500.jpg", activityBgImage: UIImage(named: "bg_my")!, activityTitle: "我的第一个活动", activityCount: 20, pageSize: 30, currentPage: 1)
        let sp3 = UserActivity(userId: self.user.userId, activityWebUrl: "", activityBgImageUrl: "http://d6.yihaodianimg.com/N07/M07/84/97/CgQI0FVApQuAfOZOAAFUOxsfr8g98600.jpg", activityBgImage: UIImage(named: "bg_my")!, activityTitle: "我的第一个活动", activityCount: 20, pageSize: 30, currentPage: 1)
        let sp4 = UserActivity(userId: self.user.userId, activityWebUrl: "", activityBgImageUrl: "http://d7.yihaodianimg.com/N05/M0B/FC/73/CgQI01U--RiAe61OAADEaGK8HzU50900.jpg", activityBgImage: UIImage(named: "bg_my")!, activityTitle: "我的第一个活动", activityCount: 20, pageSize: 30, currentPage: 1)
        let sp5 = UserActivity(userId: self.user.userId, activityWebUrl: "", activityBgImageUrl: "http://d6.yihaodianimg.com/N07/M0A/88/B1/CgQIz1VCJ9OAAR2bAAFN57xssJE96600.jpg", activityBgImage: UIImage(named: "bg_my")!, activityTitle: "我的第一个活动", activityCount: 20, pageSize: 30, currentPage: 1)
        let sp6 = UserActivity(userId: self.user.userId, activityWebUrl: "", activityBgImageUrl: "http://d6.yihaodianimg.com/N05/M01/01/C6/CgQI01VATM-ANYzqAAFM6_k2CQM53000.jpg", activityBgImage: UIImage(named: "bg_my")!, activityTitle: "我的第一个活动", activityCount: 20, pageSize: 30, currentPage: 1)
        let sp7 = UserActivity(userId: self.user.userId, activityWebUrl: "", activityBgImageUrl: "http://d6.yihaodianimg.com/N05/M03/19/D3/CgQI01VIhQmAVfoyAACp_gFnPDc55000.jpg", activityBgImage: UIImage(named: "bg_my")!, activityTitle: "我的第一个活动", activityCount: 20, pageSize: 30, currentPage: 1)
        activitys.addObjectsFromArray([sp1,sp2,sp3,sp4,sp5,sp6,sp7])
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    
    func loadRemoteData(){
        self.refreshControl?.beginRefreshing()
        Alamofire.request(.GET, "http://localhost:8080/hot/x_queryUserMessagePage.action", parameters: ["id":self.user.userId]).responseJSON {
            (_,_,json,error) -> Void in
            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let j = json as? NSDictionary {
                    var msg: String = j.valueForKey("msg") as! String
                    if(msg == "1"){
                        var s:NSArray = j.valueForKey("t") as! NSArray
                        for ap in s{
                            let sp = UserActivity(userId: (ap["userId"] as! Int), activityWebUrl: ap["activityWebUrl"] as! String, activityBgImageUrl: ap["activityWebUrl"] as! String, activityBgImage: UIImage(named: "bg_my")!, activityTitle: ap["activityTitle"] as! String, activityCount: (ap["activityCount"] as! Int), pageSize: (ap["pageSize"] as! Int), currentPage: (ap["currentPage"] as! Int))
                            self.activitys.addObject(sp)
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.refreshControl?.endRefreshing()
                            self.tableView.reloadData()
                        })
                    }
                }
            })
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView:UITableView)->Int{
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 180
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return activitys.count
    }
    //设置section高度
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 4
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform  = CATransform3DMakeTranslation(1, 1, 1)
        })
    }
    
    
    
}
