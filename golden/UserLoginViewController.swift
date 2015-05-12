//
//  LoginViewController.swift
//  golden
//
//  Created by 张立 on 15/5/6.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire

class UserLoginViewController: UIViewController,UITextFieldDelegate {
    
    let returnButton:UIButton!
    let userNameTextFiled:UITextField!
    let userPassTextFiled:UITextField!
    let headerLine:UIImageView!
    let header:UIView!
    let headerLabel:UILabel!
    let loginButton:UIButton!
    let forgetUILabel:UILabel!
    let headerRightLabel:UILabel!
    let tapRec = UITapGestureRecognizer()
    let headerRightLabelTap = UITapGestureRecognizer()//已有账号
    
    
    init(){
        var w=UIScreen.mainScreen().bounds.size.width
        returnButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        returnButton.frame =  CGRect(x: 15, y: 30, width: 25, height: 25)
        returnButton.setBackgroundImage(UIImage(named:"btn_back"), forState: UIControlState.Normal)
        header = UIView(frame: CGRect(x: 0, y: 0, width: w, height: navigationBarHeight))
        headerLine = UIImageView(frame: CGRect(x: 0, y: navigationBarHeight, width: w, height: 0.5))
        headerLabel = UILabel(frame: CGRectMake(0,24,w,40))
        headerRightLabel = UILabel(frame: CGRect(x: w-55, y: 24, width: 40, height: 40))
        userNameTextFiled = UITextField(frame: CGRect(x: 15, y: header.frame.height+20, width: w-30, height: 52))
        userNameTextFiled.backgroundColor = UIColor.whiteColor()
        userPassTextFiled = UITextField(frame: CGRect(x: 15, y: userNameTextFiled.frame.maxY+10, width: w-30, height: 52))
        userPassTextFiled.backgroundColor = UIColor.whiteColor()
        loginButton = UIButton.buttonWithType(.System) as! UIButton
        loginButton.frame = CGRectMake(15, userPassTextFiled.frame.maxY+20, w-30, 54)
        forgetUILabel = UILabel(frame: CGRectMake(115,loginButton.frame.maxY+10,loginButton.frame.width-100,40))
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //点击空白处关闭键盘
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        userNameTextFiled.resignFirstResponder()
        userPassTextFiled.resignFirstResponder()
    }
    
    
    
    
    override func viewDidLoad() {
       
        
       
        super.viewDidLoad()
        let w  = view.frame.width
        let h = view.frame.height
        view.backgroundColor = AUTO_BODY_COLOR
        header.backgroundColor = AUTO_NAVIGATIONBAR_COLOR
        returnButton.addTarget(self, action: "canleButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        headerLine.image = UIImage(named: "cutline-1")
        header.addSubview(headerLine)
        
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.text = "登录"
        headerLabel.font = UIFont.boldSystemFontOfSize(17)
        
        headerRightLabel.textAlignment = NSTextAlignment.Right
        headerRightLabel.text = "注册"
        headerRightLabel.font = UIFont.systemFontOfSize(17)
        headerRightLabel.textColor = UIColor.darkGrayColor()
        
        headerRightLabelTap.addTarget(self, action: "headerRightLabelTapClick")
        headerRightLabel.addGestureRecognizer(headerRightLabelTap)
        headerRightLabel.userInteractionEnabled = true
        
        header.addSubview(returnButton)
        header.addSubview(headerLabel)
        header.addSubview(headerRightLabel)
        
        view.addSubview(header)
        
        
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
        let userNameImage = UIImageView(frame: CGRect(x: 50, y: 16, width: 1, height: 20))
        userNameImage.image = UIImage(named: "cutline")
        ui.addSubview(leftLabel)
        ui.addSubview(userNameImage)
        
        userNameTextFiled.leftView = ui
        userNameTextFiled.leftViewMode = UITextFieldViewMode.Always
        
        
        self.view.addSubview(userNameTextFiled)
        
        
        
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
        
        loginButton.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.view.addSubview(loginButton)
        
        let loginImg = UIImageView(frame: CGRect(x: 0, y: 0, width: loginButton.frame.width, height: 54))
        loginImg.image = UIImage(named:"btn_red")
        
        loginButton.addSubview(loginImg)
        
        let loginTextLable = UILabel(frame: CGRect(x: 0, y: 12, width: loginButton.frame.width, height: 30))
        loginTextLable.numberOfLines = 1
        loginTextLable.textAlignment = NSTextAlignment.Center
        loginTextLable.font = UIFont.boldSystemFontOfSize(15)
        loginTextLable.textColor = UIColor.whiteColor()
        loginTextLable.text = "登    录"
        loginButton.addSubview(loginTextLable)
        
        
        forgetUILabel.text = "找回密码"
        forgetUILabel.font = UIFont.systemFontOfSize(12)
        forgetUILabel.textColor = UIColor.darkGrayColor()
        forgetUILabel.textAlignment = NSTextAlignment.Right
        tapRec.addTarget(self, action: "forgetClick")
        forgetUILabel.addGestureRecognizer(tapRec)
        forgetUILabel.userInteractionEnabled = true
        
        self.view.addSubview(forgetUILabel)
        
    }
    
    
    func headerRightLabelTapClick(){
        let userRegeistViewController = UserRegeistViewController()
        userRegeistViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(userRegeistViewController,animated:true, completion:nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func canleButtonClick(sender:UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
        rootController.changeIndex(0)
    }
    
    func forgetClick(){
        println("忘记密码")
    }
    
    
    
    func buttonAction(sender:UIButton){
        self.login()
        //self.loginTest()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginTest(){
        document.saveLoginMessage("1")
        //self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func alert(){
        let alertController = UIAlertController(title: "", message: "登录中，请稍后....", preferredStyle: UIAlertControllerStyle.Alert)
        //alertController.addAction(UIAlertAction(title: "确认", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func login(){
        alert()
        userNameTextFiled.resignFirstResponder()
        userPassTextFiled.resignFirstResponder()
        
        let user_login_name = userNameTextFiled.text
        let password = userPassTextFiled.text
        
        
        alamofireManager!.request(.POST, "http://192.168.92.202/api/user/userLogin", parameters: ["params":"{'user_login_name':'\(user_login_name)','password':\(password)}"]).responseJSON {
            (_,_,json,error) -> Void in
            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let j = json as? NSDictionary {
                    var msg: String = j.valueForKey("code") as! String
                    if(msg == "100"){
                        var ap:NSDictionary = j.valueForKey("body") as! NSDictionary
                        let ko = MineModel(userId: (ap["id"] as! Int), userName: ap["user_login_name"] as! String, userSix: ap["sex"] as! String, userTel: ap["mobile_phone"] as! String, userNote: ap["user_real_name"] as! String,userBgUrl: ap["background_url"] as! String, userHeaderUrl: ap["avatar"] as! String,userPersonBgUrl:ap["background_url"] as! String,userBgImage:UIImage(named: "bg_my")!,userHeadeImage:UIImage(named: "pic_head_big")!,userPersonBgImage:UIImage(named: "bg_personal")!,gzCount:11,fsCount:33,xhCount:45)
                        //self.source.addObject(ko)
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            document.saveLoginMessage(String(ko.userId))
                            self.dismissViewControllerAnimated(true, completion: ({
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }))
                        })
                    }else{
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.dismissViewControllerAnimated(true, completion: nil)
                            SweetAlert().showAlert("登录失败!", subTitle: "用户名或密码错误，请重新登录！", style: AlertStyle.Error)
                        })
                    }
                }
            })
            } else{
                self.dismissViewControllerAnimated(true, completion: nil)
                SweetAlert().showAlert("登录失败!", subTitle: "服务器异常，请稍后再试！", style: AlertStyle.Error)
            }
        }
    }
}

