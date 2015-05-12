//
//  ChatDataSource.swift
//  golden-laser
//
//  Created by 张立 on 15/4/21.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import Foundation

/*
数据提供协议
*/
protocol ChatDataSource{
    
    func rowsForChatTable( tableView:TableView) -> Int
    
    func chatTableView(tableView:TableView, dataForRow:Int)-> MessageItem
    
    func textFieldResignFirstResponder()
    
}