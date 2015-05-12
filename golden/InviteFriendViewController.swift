//
//  inviteFriendController.swift
//  golden
//
//  Created by 蔡崇博 on 15/5/9.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class InviteFriendViewController: UITableViewController,UISearchBarDelegate  {
    
    var searchBar : UISearchBar!
    // 搜索匹配的结果，Table View使用这个数组作为datasource
    var ctrlsel:[String] = []
    
    let contents = ["新浪微博","手机通讯录","推荐给微信好友","推荐给QQ好友"]
    let imgs = ["img_weibo","img_call","img_wechat","img_qq"]

    
    //该导航需要设置的
    var NavigationController:UINavigationController!
    
    init(){
         super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.title = "邀请好友"

        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        searchBar = UISearchBar(frame: CGRect(x: 10, y: 15, width: self.view.frame.width-20, height: 30))

        var headerview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width-20, height: 60))
        headerview.backgroundColor = UIColor(rgb: 0xf3f4f6)
        searchBar.placeholder = "搜索我秀网好友"
        headerview.addSubview(searchBar)
        self.tableView.tableHeaderView = headerview
        

       // self.tableView.tableHeaderView?.addSubview(searchBar)
    }
    
    //设置section高度
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
//        return 10
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let row:Int = indexPath.row
        
        let identiString = "Cell"
        var contentCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identiString)
        contentCell.textLabel?.text = contents[row]
        contentCell.imageView?.image = UIImage(named: imgs[row])!
        return contentCell
    }
  
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // 没有搜索内容时显示全部组件
 /*       if searchText == "" {
            self.ctrlsel = self.ctrls
        }
        else { // 匹配用户输入内容的前缀
            self.ctrlsel = []
            for ctrl in self.ctrls {
                if ctrl.lowercaseString.hasPrefix(searchText) {
                    self.ctrlsel.append(ctrl)
                }
            }
        }*/
        // 刷新Table View显示
        self.tableView.reloadData()
    }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
    //func searchBarSearchButtonClicked(searchBar: UISearchBar!) {
    //searchBar.resignFirstResponder()
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}