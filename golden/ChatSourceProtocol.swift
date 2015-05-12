//
//  ChatSourceProtocol.swift
//  golden
//
//  Created by 蔡崇博 on 15/5/8.
//  Copyright (c) 2015年 张立. All rights reserved.
//


import Foundation


protocol ChatSourceProtocol{
    
    func loadData() -> NSMutableArray
    
    func loadSheet() -> Void
}