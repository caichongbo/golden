//
//  UserSetingViewController.swift
//  golden
//
//  Created by 张立 on 15/5/7.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
var USERSETING_JUMPER = 0
class UserSetingViewController: UITableViewController {
    
    let content = ["版本号 1.0.0","清理缓存","退出系统"]
    
    init(){
        super.init(nibName: nil, bundle: nil)
        title = "设置"
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let w = view.frame.width
        view.backgroundColor = UIColor(rgb: 0xf3f4f6)
        
        
        self.tableView.registerClass(UserSetingContentCell.self, forCellReuseIdentifier: "UserSetingContentCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func loginOutButtonClick(sender:UIButton){
        println("loginOut")
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        let row:Int = indexPath.row
        if row != 2 {
            return 55
        }else{
            return 65
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        rootController.showOrhideToolbar(false)
        self.navigationController?.navigationBar.hidden =  false
        let back = UIBarButtonItem()
        back.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        self.navigationItem.backBarButtonItem = back
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row:Int = indexPath.row
        let con = content[row]
        if row != 2{
            var contentCell = tableView.dequeueReusableCellWithIdentifier("UserSetingContentCell", forIndexPath: indexPath) as? UserSetingContentCell
            contentCell?.setData(con)
            if row == 1 {
                contentCell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            }
            contentCell!.selectionStyle = UITableViewCellSelectionStyle.None
            return contentCell!
        }else{
            var contentCell = UserSetingLoginOutCell(reuseIdentifier: "UserSetingLoginOutCell")
            contentCell.setData(UIImage(named: "btn_red")!,labelText:con)
            contentCell.selectionStyle = UITableViewCellSelectionStyle.None
            return contentCell
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        
        if row == 1 {
            let userSetingViewController =  UserClearDocumentViewController()
            navigationController!.pushViewController(userSetingViewController, animated: true)
        } else if row == 2 {
            SweetAlert().showAlert("确定退出?", subTitle: "", style: AlertStyle.Warning, buttonTitle:"取消", buttonColor:UIColorFromRGB(0xD0D0D0) , otherButtonTitle:  "确定", otherButtonColor: UIColorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    println("Cancel Button  Pressed")
                }else {
                    document.clearDataOfPlist(User_Plist)
                    USERSETING_JUMPER = 1
                    self.navigationController?.popToRootViewControllerAnimated(true)
                    //rootController.changeIndex(0)
                }
            }
        }
    }
}
