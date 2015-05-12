//
//  UserClearDocumentViewController.swift
//  golden
//
//  Created by 张立 on 15/5/7.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit

class UserClearDocumentViewController: UIViewController {
    
    var circularProgress1: KYCircularProgress!
    var currentCount: Double = 0
    var dataCount: Double = 0
    let op:DocumentForOc = DocumentForOc()
    var timer:NSTimer!
    var hasDelete = false
    var w:CGFloat = 0
    var haveClearLabel:UILabel!
    
    init(){
        super.init(nibName: nil, bundle: nil)
        dataCount = queryCurrentSize()
    }
    
    func deleteDocument(){
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        op.deletefileForDir(documentsDirectory as String)
        document.clearDataOfPlist(Image_Plist)
    }
    
    func queryCurrentSize() ->Double{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        return Double(op.fileSizeForDir(documentsDirectory as String))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        w  = view.frame.width
        let h = view.frame.height
        let vi = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        vi.image = UIImage(named: "background")
        self.view.addSubview(vi)
        configureKYCircularProgress1()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: Selector("updateProgress"), userInfo: nil, repeats: true)
        deleteDocument()
        
    }
    
    func configureKYCircularProgress1() {
        let circularProgress1Frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/2)
        circularProgress1 = KYCircularProgress(frame: circularProgress1Frame)
        
        let center = CGPoint(x: w/2, y: 300.0)
        circularProgress1.path = UIBezierPath(arcCenter: center, radius: CGFloat(CGRectGetWidth(circularProgress1.frame)/3), startAngle: CGFloat(M_PI), endAngle: CGFloat(0.0), clockwise: true)
        circularProgress1.colors = [UIColor(rgba: 0xA6E39DAA), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xAEC1E3AA), UIColor(rgba: 0xF3C0ABAA)]
        circularProgress1.lineWidth = 8.0
        circularProgress1.showProgressGuide = true
        circularProgress1.progressGuideColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.4)
        
        let textLabel = UILabel(frame: CGRectMake(0, 270.0, w, 32.0))
        textLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 32)
        textLabel.textAlignment = .Center
        textLabel.textColor = UIColor.greenColor()
        textLabel.alpha = 0.3
        view.addSubview(textLabel)
        
        haveClearLabel = UILabel(frame: CGRectMake(0, 350, w, 32.0))
        haveClearLabel.font = UIFont(name: "HelveticaNeue-UltraLight", size: 17)
        haveClearLabel.textAlignment = .Center
        haveClearLabel.textColor = UIColor.greenColor()
        haveClearLabel.alpha = 0.5
        view.addSubview(haveClearLabel)
        
        circularProgress1.progressChangedClosure({ (progress: Double, circularView: KYCircularProgress) in
            textLabel.text = "\(Int(progress * 100.0))%"
        })
        
        self.view.addSubview(circularProgress1)
    }
    
    func updateProgress() {
        if currentCount<=100{
            currentCount = currentCount + 1
            let normalizedProgress = currentCount / 100
            circularProgress1.progress = normalizedProgress
            if currentCount == 100 {
                let str = String(format:"%.2f",dataCount)
                haveClearLabel.text = "成功清除"+str+"兆缓存！"
            }
        }
    }
    
    override func viewDidDisappear(animated: Bool){
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
}
