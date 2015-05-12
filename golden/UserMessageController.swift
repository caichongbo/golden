//
//  UserMessageController.swift
//  golden-laser
//
//  Created by 张立 on 15/4/23.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire
//个人信息
class UserMessageController:UIViewController,UserSourceProtocol,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    //声明一个UIAlertController实例
    var controller: UIAlertController!
    
    
    var userId: Int = 0
    var table:UserTableView!
    var source:NSMutableArray!
    var savedImage:UIImage!
    let imagePickerController:UIImagePickerController!
    
    
    init(userId: Int) {
        self.userId = userId
        println("\(userId)")
        imagePickerController = UIImagePickerController()
        super.init(nibName: nil, bundle: nil)
        title = "个人信息"
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var w = view.frame.width
        var h = view.frame.height
        view.backgroundColor = UIColor.darkGrayColor()
        
        
        //创建UIAlertController实例
        //controller = UIAlertController(title: tmpString, message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        controller = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        //        let action = UIAlertAction(title: "拍照", style: UIAlertActionStyle.Destructive) {
        //            (paramAction: UIAlertAction!) -> Void in
        //            //执行action回调函数
        //            //判断弹出框中是否有textFields输入框
        //            if let textFields = self.controller.textFields{
        //                let texts = textFields as! [UITextField] //获取弹出框中的所有textFields是个数组
        //                let text = texts[0].text
        //                println("输入内容是：\(text)")
        //            }
        //        }
        
        let action1 = UIAlertAction(title: "从手机相册选择", style: UIAlertActionStyle.Destructive) {
            (paramAction: UIAlertAction!) -> Void in
            println("从手机相册选择")
            self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.imagePickerController.navigationBar.barTintColor = UIColor(red: 171/255, green: 202/255, blue: 41/255, alpha: 1.0)
            self.imagePickerController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
            self.imagePickerController.navigationBar.tintColor = UIColor.whiteColor()
            self.presentViewController(self.imagePickerController, animated: true, completion: nil)
        }
        
        let action2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) {
            (paramAction: UIAlertAction!) -> Void in
            println("取消")
        }
        
        
        
        //controller.addAction(action0)
        controller.addAction(action1)
        controller.addAction(action2)
        
        
        self.table = UserTableView(navigationController: self.navigationController!,frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        self.table.keyboardDismissMode = .Interactive
        view.addSubview(table)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() -> NSMutableArray{
        return source
    }
    
    func loadSheet() {
        //执行点击按钮时弹出对话框
        self.imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        self.imagePickerController.allowsEditing = true
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    // 当用户取消时，调用该方法
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image: UIImage!
        // 判断，图片是否允许修改
        if(picker.allowsEditing){
            //裁剪后图片
            image = info[UIImagePickerControllerEditedImage] as! UIImage
        }else{
            //原始图片
            image = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        /* 此处info 有六个值
        * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
        * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
        * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
        * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
        * UIImagePickerControllerMediaURL;       // an NSURL
        * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
        * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
        */
        // 保存图片至本地，方法见下文
        
        
        let fullPath = document.bulidImagePath("currentUserPhoto.png")
        document.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 1, fullPath: fullPath)
        savedImage = UIImage(contentsOfFile: fullPath)!
        self.dismissViewControllerAnimated(true, completion: nil)
        uploadFile(image)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        if animated {
            self.tabBarController?.tabBar.hidden =  true//关闭尾部导航条
            source = NSMutableArray()
            let User =  UserMessageModel(userId: userId, userName: "帅哥", userSix: "男", userTel: "18995533870", userNote: "我是帅哥", userBgUrl: "", userHeaderUrl: "pic_head_big")
            source.addObject(User)
            self.table.mineSourceProtocol = self
            self.table.reloadData()
            //loadRemoteData()
        }
    }
    
    
    func loadRemoteData(){
        Alamofire.request(.GET, "http://localhost:8080/hot/x_queryUserMessagePage.action", parameters: ["id":self.userId]).responseJSON {
            (_,_,json,error) -> Void in
            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let j = json as? NSDictionary {
                    var msg: String = j.valueForKey("msg") as! String
                    if(msg == "1"){
                        var s:NSArray = j.valueForKey("t") as! NSArray
                        for ap in s{
                            let sp = UserMessageModel(userId: (ap["userId"] as! Int), userName: ap["userName"] as! String, userSix: ap["userSix"] as! String, userTel: ap["userTel"] as! String,userNote: ap["userNote"] as! String,userBgUrl: ap["userBgUrl"] as! String,userHeaderUrl: ap["userHeaderUrl"] as! String)
                            self.source.addObject(sp)
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.table.reloadData()
                        })
                    }
                }
            })
            }
        }
    }
    
    func uploadFile(img:UIImage){
        var obj: UploadImage = UploadImage()
        obj.uploadPhoto(img, requestUrl: "http://192.168.82.108/api/upload/uploadImage", userId: "2222")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        rootController.showOrhideToolbar(false)
    }
    
}
