//
//  HotRootViewController.swift
//  golden
//
//  Created by 张立 on 15/5/4.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class HotRootViewController:UIViewController {
    
    
    

    
    class func HotInit()->UIViewController{
        var home = UIStoryboard(name: "Hot", bundle: nil).instantiateInitialViewController() as! UIViewController
        return home
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let w = self.view.frame.width
        view.backgroundColor = UIColor.whiteColor()
        let label1 = UILabel(frame: CGRect(x: 0, y: 100, width: w, height: 20))
        label1.text = "开发中....."
        label1.textColor = UIColor.blackColor()
        label1.font = UIFont.boldSystemFontOfSize(14)
        label1.textAlignment = NSTextAlignment.Center
        
        
        
        self.view.addSubview(label1)
        
        title = "热点"
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender:UIButton){
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rootController.showOrhideToolbar(true)
    }
}
