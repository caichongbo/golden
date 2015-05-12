//
//  PlayRootViewController.swift
//  golden
//
//  Created by 张立 on 15/5/4.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class PlayRootViewController: UIViewController {

    
    let label=UILabel()
    
    
    
    class func PlayInit()->UIViewController{
        var home = UIStoryboard(name: "play", bundle: nil).instantiateInitialViewController() as! UIViewController
        return home
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "玩定制"
        
        let w = self.view.frame.width
        view.backgroundColor = UIColor.whiteColor()
        label.frame = CGRectMake(0, 100,w,20)
        label.text = "开发中...."
        label.textColor = UIColor.blackColor()
        label.font = UIFont.boldSystemFontOfSize(14)
        label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(label)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rootController.showOrhideToolbar(true)
    }
    
}
