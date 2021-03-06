//
//  TableView.swift
//  golden-laser
//
//  Created by 张立 on 15/4/21.
//  Copyright (c) 2015年 张立. All rights reserved.
//



import UIKit
enum ChatBubbleTypingType
{
    case Nobody
    case Me
    case Somebody
}
class TableView:UITableView,UITableViewDelegate, UITableViewDataSource{
    
    var bubbleSection:NSMutableArray!
    var chatDataSource:ChatDataSource!
    
    var  snapInterval:NSTimeInterval!
    var  typingBubble:ChatBubbleTypingType!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame:CGRect){
        //the snap interval in seconds implements a headerview to seperate chats
        self.snapInterval = 60 * 60 * 24; //one day
        self.typingBubble = ChatBubbleTypingType.Nobody
        self.bubbleSection = NSMutableArray()
        
        super.init(frame:frame,  style:UITableViewStyle.Grouped)
        
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = UITableViewCellSeparatorStyle.None  
        self.delegate = self
        self.dataSource = self
    }
    
    //按日期排序方法
    func sortDate(m1: AnyObject!, m2: AnyObject!) -> NSComparisonResult {
        if((m1 as! MessageItem).date.timeIntervalSince1970 < (m2 as! MessageItem).date.timeIntervalSince1970){
            return NSComparisonResult.OrderedAscending
        } else {
            return NSComparisonResult.OrderedDescending
        }
    }
    
    override func reloadData(){
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bubbleSection = NSMutableArray()
        var count =  0
        if ((self.chatDataSource != nil)){
            count = self.chatDataSource.rowsForChatTable(self)
            if(count > 0){
                var bubbleData =  NSMutableArray(capacity:count)
                for (var i = 0; i < count; i++){
                    var object =  self.chatDataSource.chatTableView(self, dataForRow:i)
                    bubbleData.addObject(object)
                }
                var currentSection = NSMutableArray()
                self.bubbleSection.addObject(currentSection)
                bubbleData.sortUsingComparator(sortDate)
                for (var i = 0; i < count; i++){
                    var data =  bubbleData[i] as? MessageItem
                    self.bubbleSection[0].addObject(data!)
                }
               super.reloadData()
               if self.bubbleSection[0].count > 1 {
                    var indexPath =  NSIndexPath(forRow:self.bubbleSection[0].count - 1,inSection:0)
                    self.scrollToRowAtIndexPath(indexPath,atScrollPosition:UITableViewScrollPosition.Bottom,animated:true)
               }
            }
        }
        //滑向最后一部分
        //var secno = self.bubbleSection.count - 1
        
    }
    
    //指定有多少个分区(Section)，默认为1
    func numberOfSectionsInTableView(tableView:UITableView)->Int{
        return 1
    }
    
    //指定每个分区中有多少行，默认为1
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.chatDataSource.rowsForChatTable(self)
    }
    
    //改变行的高度
    func tableView(tableView:UITableView,heightForRowAtIndexPath  indexPath:NSIndexPath) -> CGFloat{

        var data: AnyObject! =  self.bubbleSection[0][indexPath.row]
        var item =  data as! MessageItem
        var height  = max(item.insets.top + item.view.frame.size.height + item.insets.bottom, 80)
        println("height:\(height)")
        return height
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        println("点击cell")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        //var contentCell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as? TableViewCell
        //var data =  self.chatDataSource.chatTableView(self, dataForRow:indexPath.row)
        if self.bubbleSection.count != 0 {
            if self.bubbleSection[0].count != 0 {
                var data: AnyObject! =  self.bubbleSection[0][indexPath.row]
                var item =  data as! MessageItem
                var cell =  TableViewCell(data:item, reuseIdentifier:"TableViewCell")
                return cell
            }
        }
        return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "nilCell")
    }
}
