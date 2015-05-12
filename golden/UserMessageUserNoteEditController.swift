//
//  UserMessageUserNoteEditController.swift
//  golden-laser
//
//  Created by 张立 on 15/4/28.
//  Copyright (c) 2015年 张立. All rights reserved.
//用户个性签名变更

import UIKit

class UserMessageUserNoteEditController:UIViewController,UITextViewDelegate {
    
    var source:UserMessageModel!
    var textView: UITextView!
    var labHolder:UITextField!
    var saveButton: UIBarButtonItem!
    
    init(source:UserMessageModel,pageTitle:String){
        self.source = source
        super.init(nibName: nil, bundle: nil)
        title = pageTitle
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //添加头部导航按钮
    func addNavigationItemButton(){
        saveButton = UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "saveClick")
        saveButton.tintColor = UIColor.redColor()
        navigationItem.rightBarButtonItem = saveButton
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNavigationItemButton()
        
        
        self.view.backgroundColor = UIColor(white: 250/255, alpha: 1)
        var w = view.frame.width
        var sendView = UIView(frame:CGRectMake(0,70,w,200))
        textView = UITextView(frame: CGRect(x: 10, y: 10, width: w-20, height: 150))
        textView.delegate = self
        textView.font = UIFont.systemFontOfSize(14)
        textView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 205/255, alpha:1).CGColor//设置边框颜色
        textView.layer.borderWidth = 0.5
        textView.layer.cornerRadius = 5 //设置圆角
        textView.scrollsToTop = false
        
        self.automaticallyAdjustsScrollViewInsets = false
        textView.text = source.userNote
        super.view.addSubview(sendView)
        sendView.addSubview(textView)
        
        labHolder = UITextField(frame: CGRect(x: w-50, y: textView.frame.height-10, width: 40, height:15))
        
        labHolder.font = UIFont.boldSystemFontOfSize(10)
        //        let placeholder = NSAttributedString(string: "30", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        //lab.attributedPlaceholder = placeholder
        
        
        let length = textView.text.lengthOfBytesUsingEncoding(NSUnicodeStringEncoding)
        labHolder.placeholder = String(length/2)+"/200"
        
        
        
        sendView.addSubview(labHolder)
        textView.returnKeyType = UIReturnKeyType.Done
        textView.becomeFirstResponder()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool{
        
        let s = String(range.location)
        labHolder.placeholder = s+"/200"
        
        if range.location >= 200{
            textView.resignFirstResponder()
            return false
        }
       
        if text=="\n"{
            textView.resignFirstResponder()
            updateUserNote()
            self.navigationController?.popViewControllerAnimated(true)
        }
        return true
    }
    
//    //    func textViewDidChange(textView: UITextView){
//        let length = textView.text.lengthOfBytesUsingEncoding(NSUnicodeStringEncoding)
//        labHolder.placeholder = String(length/2)+"/200"
//        
//        if length>20{
//           
//        }
//    }

    
    override func viewWillAppear(animated: Bool) {
        if animated {
            self.tabBarController?.tabBar.hidden =  true//关闭尾部导航条
        }
    }
    //触发头部保存按钮
    func saveClick(){
        textView.resignFirstResponder()
        updateUserNote()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //更新用户签名信息
    func updateUserNote(){
        let alr = AlamofireUtil()
        alr.updateUser("http://localhost:8080/hot/x_updateUserMessage.action", parameters: ["userId":source.userId,"userNote":textView.text])
    }
}
