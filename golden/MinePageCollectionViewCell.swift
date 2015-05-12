//
//  FloorCollectionViewCell.swift
//  golden-laser
//
//  Created by 张立 on 15/5/3.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire
class MinePageCollectionViewCell: UICollectionViewCell {
    
    let imageView:UIImageView!
    var request: Alamofire.Request?
    
    override init(frame: CGRect) {
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        super.init(frame: frame)
        self.addSubview(imageView)
    }
    
    
    func setData(image:UIImage){
        imageView.image = image
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
