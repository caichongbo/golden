//
//  UserRegeistViewController.swift
//  golden
//
//  Created by 张立 on 15/5/11.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire

class UserRegeistViewController: UIViewController,UITextFieldDelegate {
    
    var timer:NSTimer!
    let returnButton:UIButton!
    let userNameTextFiled:UITextField!
    let userPassTextFiled:UITextField!
    let markTextFiled:UITextField!
    let markLabel:UILabel!
    let headerLine:UIImageView!
    let header:UIView!
    let headerLabel:UILabel!
    let headerRightLabel:UILabel!
    let regeistButton:UIButton!
    let xieyiLabel:UILabel!
    let markLabelTap = UITapGestureRecognizer()//获取验证码手势
    let contentTap = UITapGestureRecognizer()//查看用户许可协议
    let headerRightLabelTap = UITapGestureRecognizer()//已有账号
    let TWMessageAlert: TWMessageBarManager = TWMessageBarManager()
    
    init (){
        var w=UIScreen.mainScreen().bounds.size.width
        returnButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        returnButton.frame =  CGRect(x: 15, y: 30, width: 25, height: 25)
        returnButton.setBackgroundImage(UIImage(named:"btn_back"), forState: UIControlState.Normal)
        header = UIView(frame: CGRect(x: 0, y: 0, width: w, height: navigationBarHeight))
        headerLine = UIImageView(frame: CGRect(x: 0, y: navigationBarHeight, width: w, height: 0.5))
        headerLine.image = UIImage(named: "cutline-1")
        headerLabel = UILabel(frame: CGRectMake(0,24,w,40))
        headerRightLabel = UILabel(frame: CGRect(x: w-95, y: 24, width: 80, height: 40))
        
        userNameTextFiled = UITextField(frame: CGRect(x: 15, y: header.frame.height+20, width: w-30, height: 52))
        userNameTextFiled.backgroundColor = UIColor.whiteColor()
        
        markTextFiled =  UITextField(frame: CGRect(x: 15, y: userNameTextFiled.frame.maxY+10, width: userNameTextFiled.frame.width*2/3, height: 52))
        markTextFiled.backgroundColor = UIColor.whiteColor()
        markLabel = UILabel(frame: CGRect(x: markTextFiled.frame.maxX+5, y: userNameTextFiled.frame.maxY+10, width: userNameTextFiled.frame.width-markTextFiled.frame.width-5, height: 52))
        
        userPassTextFiled = UITextField(frame: CGRect(x: 15, y: markTextFiled.frame.maxY+10, width: w-30, height: 52))
        userPassTextFiled.backgroundColor = UIColor.whiteColor()
        
        regeistButton = UIButton.buttonWithType(.System) as! UIButton
        regeistButton.frame = CGRectMake(15, userPassTextFiled.frame.maxY+20, w-30, 54)
        xieyiLabel = UILabel(frame: CGRect(x: 15, y: regeistButton.frame.maxY+20, width: w-30, height: 25))
        xieyiLabel.textColor = UIColor.darkGrayColor()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func canleButtonClick(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let w  = view.frame.width
        let h = view.frame.height
        view.backgroundColor = AUTO_BODY_COLOR
        header.backgroundColor = AUTO_NAVIGATIONBAR_COLOR
        returnButton.addTarget(self, action: "canleButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.text = "注册"
        headerLabel.font = UIFont.boldSystemFontOfSize(17)
        
        headerRightLabel.textAlignment = NSTextAlignment.Right
        headerRightLabel.text = "已有账号"
        headerRightLabel.font = UIFont.systemFontOfSize(17)
        headerRightLabel.textColor = UIColor.darkGrayColor()
        
        headerRightLabelTap.addTarget(self, action: "canleButtonClick")
        headerRightLabel.addGestureRecognizer(headerRightLabelTap)
        headerRightLabel.userInteractionEnabled = true
        
        
        header.addSubview(headerLabel)
        header.addSubview(returnButton)
        header.addSubview(headerRightLabel)
        
        view.addSubview(header)
        view.addSubview(headerLine)
        
        
        userNameTextFiled.placeholder = "请输入手机号码"
        userNameTextFiled.font = UIFont.systemFontOfSize(14)
        userNameTextFiled.delegate = self
        
        userNameTextFiled.layer.borderWidth = 0.5
        userNameTextFiled.layer.cornerRadius = 2 //设置圆角
        userNameTextFiled.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor//设置边框颜色
        userNameTextFiled.keyboardType = UIKeyboardType.NumberPad
        userNameTextFiled.contentVerticalAlignment =  UIControlContentVerticalAlignment.Center
        userNameTextFiled.clearButtonMode = UITextFieldViewMode.WhileEditing
        userNameTextFiled.returnKeyType = UIReturnKeyType.Done
        
        //设置缩进
        let ui:UIView = UIView(frame: CGRectMake(0,0,60,52))
        let leftLabel = UILabel(frame: CGRectMake(0,0,40,52))
        leftLabel.textAlignment = NSTextAlignment.Right
        leftLabel.text = "+86"
        leftLabel.font = UIFont.systemFontOfSize(14)
        let userNameImage = UIImageView(frame: CGRect(x: 50, y: 15, width: 1, height: 20))
        userNameImage.image = UIImage(named: "cutline")
        ui.addSubview(leftLabel)
        ui.addSubview(userNameImage)
        userNameTextFiled.leftView = ui
        userNameTextFiled.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(userNameTextFiled)
        
        
        markTextFiled.placeholder = "请输入验证码"
        markTextFiled.layer.borderWidth = 0.5
        markTextFiled.layer.cornerRadius = 2 //设置圆角
        markTextFiled.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor//设置边框颜色
        markTextFiled.font = UIFont.systemFontOfSize(14)
        markTextFiled.delegate = self
        markTextFiled.returnKeyType = UIReturnKeyType.Done
        markTextFiled.keyboardType = UIKeyboardType.NumberPad
        markTextFiled.contentVerticalAlignment =  UIControlContentVerticalAlignment.Center
        let markTextUi:UIView = UIView(frame: CGRectMake(0,0,5,52))
        markTextFiled.leftView = markTextUi
        markTextFiled.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(markTextFiled)
        
        
        
        markLabel.text = "立即获取"
        markLabel.layer.borderWidth = 0.5
        markLabel.layer.cornerRadius = 2 //设置圆角
        markLabel.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor//设置边框颜色
        markLabel.textColor = UIColor.whiteColor()
        markLabel.font = UIFont.boldSystemFontOfSize(14)
        markLabel.textAlignment = NSTextAlignment.Center
        markLabel.backgroundColor = UIColor(red: 97/255, green: 194/255, blue: 101/255, alpha:1)//设置边框颜色
        
        markLabelTap.addTarget(self, action: "markLabelTapClick")
        markLabel.addGestureRecognizer(markLabelTap)
        markLabel.userInteractionEnabled = true
        
        self.view.addSubview(markLabel)
        
        
        
        
        userPassTextFiled.placeholder = "请输入6到16位登录密码"
        userPassTextFiled.layer.borderWidth = 0.5
        userPassTextFiled.layer.cornerRadius = 2 //设置圆角
        userPassTextFiled.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor//设置边框颜色
        userPassTextFiled.font = UIFont.systemFontOfSize(14)
        userPassTextFiled.delegate = self
        userPassTextFiled.secureTextEntry = true
        userPassTextFiled.returnKeyType = UIReturnKeyType.Done
        userPassTextFiled.keyboardType = UIKeyboardType.NumbersAndPunctuation
        userPassTextFiled.contentVerticalAlignment =  UIControlContentVerticalAlignment.Center
        userPassTextFiled.clearButtonMode = UITextFieldViewMode.WhileEditing
        let userPassUi:UIView = UIView(frame: CGRectMake(0,0,5,52))
        userPassTextFiled.leftView = userPassUi
        userPassTextFiled.leftViewMode = UITextFieldViewMode.Always
        self.view.addSubview(userPassTextFiled)
        
        
        regeistButton.addTarget(self, action: "regeistButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(regeistButton)
        
        let loginImg = UIImageView(frame: CGRect(x: 0, y: 0, width: regeistButton.frame.width, height: 54))
        loginImg.image = UIImage(named:"btn_red")
        
        regeistButton.addSubview(loginImg)
        
        let loginTextLable = UILabel(frame: CGRect(x: 0, y: 12, width: regeistButton.frame.width, height: 30))
        loginTextLable.numberOfLines = 1
        loginTextLable.textAlignment = NSTextAlignment.Center
        loginTextLable.font = UIFont.boldSystemFontOfSize(15)
        loginTextLable.textColor = UIColor.whiteColor()
        loginTextLable.text = "注    册"
        regeistButton.addSubview(loginTextLable)
        
        var myString = "点击注册即同意3DiShow的《用户许可协议》"
        var myMutableString = NSMutableAttributedString(string: myString , attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 12.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location:15,length:8))
        xieyiLabel.attributedText = myMutableString
        contentTap.addTarget(self, action: "contentTapClick")
        xieyiLabel.addGestureRecognizer(contentTap)
        xieyiLabel.userInteractionEnabled = true
        self.view.addSubview(xieyiLabel)
        
        // Do any additional setup after loading the view.
    }
    
    //点击空白处关闭键盘
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        userNameTextFiled.resignFirstResponder()
        userPassTextFiled.resignFirstResponder()
        markTextFiled.resignFirstResponder()
    }
    
    
    func markLabelTapClick(){
        println("促发点击")
        getMark()
        markLabel.removeGestureRecognizer(markLabelTap)
        markLabel.textColor = UIColor.grayColor()
        markLabel.backgroundColor = UIColor.darkGrayColor()
        timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("updateColor"), userInfo: nil, repeats: false)
    }
    
    func contentTapClick(){
        println("点击用户许可协议")
    }
    
    
    
    func updateColor(){
        println("定时更新")
        markLabel.addGestureRecognizer(markLabelTap)
        markLabel.userInteractionEnabled = true
        markLabel.textColor = UIColor.whiteColor()
        markLabel.backgroundColor = UIColor(red: 97/255, green: 194/255, blue: 101/255, alpha:1)
        document.clearTokenCode
    }
    
    func regeistButtonClick(sender:UIButton){
        
        let token =  document.queryTokenMessage()
        if markTextFiled.text == token {
            
        } else {
             SweetAlert().showAlert("验证码输入有误", subTitle: "请输入有效验证码！", style: AlertStyle.Error)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool){
        if let x = timer {
            self.timer.invalidate()
        }
        super.viewWillDisappear(animated)
    }
    
    func getMark(){
        var regeistToken = ""
        alamofireManager!.request(.POST, "http://192.168.92.202/api/userReg/getToken", parameters: ["mobilePhone":"\(userNameTextFiled.text)"]).responseJSON {
            (_,_,json,error) -> Void in
            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let j = json as? NSDictionary {
                    var msg: String = j.valueForKey("code") as! String
                    if(msg == "100"){
                        var ap:NSDictionary = j.valueForKey("body") as! NSDictionary
                        regeistToken = ap["token"] as! String
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            document.saveTokenMessage(regeistToken)
                            println("验证码为:"+regeistToken)
                        })
                    }
                }
            })
            } else{
                SweetAlert().showAlert("获取验证码失败!", subTitle: "服务器异常，请稍后再试！", style: AlertStyle.Error)
            }
        }
    }
}
