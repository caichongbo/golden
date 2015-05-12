//
//  UserSampleNameController.swift
//  golden-laser
//
//  Created by 张立 on 15/4/27.
//  Copyright (c) 2015年 张立. All rights reserved.
//
//用户昵称变更

import UIKit
import Alamofire

class UserMessageUserNameEditController: UIViewController,UITextFieldDelegate {
    
    
    
    var source:UserMessageModel!
    var txtMsg:UITextField!
    var saveButton: UIBarButtonItem!
    
    init(source:UserMessageModel,pageTitle:String){
        self.source = source
        super.init(nibName: nil, bundle: nil)
        title = pageTitle
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
    //        if range.location == 0{
    //            return false
    //        }else if range.location == 50{
    //            return false
    //        }
    //        return true
    //    }
    
    //添加头部导航按钮
    func addNavigationItemButton(){
        saveButton = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "saveClick")
        saveButton.tintColor = UIColor.redColor()
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        var w = view.frame.width
        var h = view.frame.height
        
        addNavigationItemButton()

        
        var sendView = UIView(frame:CGRectMake(0,70,w,300))
        sendView.backgroundColor = UIColor(white: 250/255, alpha: 1)
        txtMsg = UITextField(frame:CGRectMake(10,0,w-20,30))
        txtMsg.backgroundColor = UIColor.whiteColor()
        txtMsg.textColor=UIColor.blackColor()
        txtMsg.font=UIFont(name: "HelveticaNeue", size: 12)
        
        txtMsg.layer.borderWidth = 0.5
        txtMsg.layer.cornerRadius = 5 //设置圆角
        txtMsg.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor//设置边框颜色
        txtMsg.returnKeyType = UIReturnKeyType.Done
        txtMsg.contentVerticalAlignment =  UIControlContentVerticalAlignment.Center
        txtMsg.clearButtonMode = UITextFieldViewMode.WhileEditing
        //设置缩进
        let ui:UIView = UIView(frame: CGRectMake(0,0,5,5))
        txtMsg.leftView = ui
        txtMsg.leftViewMode = UITextFieldViewMode.Always
        
        //Set the delegate so you can respond to user input
        txtMsg.delegate=self
        txtMsg.text = source.userName
        txtMsg.becomeFirstResponder()
        sendView.addSubview(txtMsg)
        self.view.addSubview(sendView)
        
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        updateUserName()
        self.navigationController?.popViewControllerAnimated(true)
        return true
    }
    
    
//    func loadRemoteData(){
//        Alamofire.request(.POST, "http://localhost:8080/hot/x_updateUserMessage.action", parameters: ["userId":self.source.userId,"index":self.source.index,"text":txtMsg.text]).responseJSON {
//            (_,_,json,error) -> Void in
//            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
//                if let j = json as? NSDictionary {
//                    
//                }
//            })
//            }
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if animated {
            self.tabBarController?.tabBar.hidden =  true//关闭尾部导航条
        }
    }
    
    //触发头部保存按钮
    func saveClick(){
        txtMsg.resignFirstResponder()
        updateUserName()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //更新用户签名信息
    func updateUserName(){
        let alr = AlamofireUtil()
        alr.updateUser("http://localhost:8080/hot/x_updateUserMessage.action", parameters: ["userId":source.userId,"userNote":txtMsg.text])
    }
}
