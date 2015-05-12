//
//  MineSourceProtocol.swift
//  golden-laser
//
//  Created by 张立 on 15/4/24.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import Foundation


protocol UserSourceProtocol{

    func loadData() -> NSMutableArray
    
    func loadSheet() -> Void
}