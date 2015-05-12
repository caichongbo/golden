//
//  MineScrollPageViewController.swift
//  golden-laser
//
//  Created by 张立 on 15/5/3.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
import Alamofire

class MinePageViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    
    var floorResultCollectionView:UICollectionView!
    var source:NSMutableArray!
    var storys:NSMutableArray!
    let user:MineModel!
    let returnButton:UIButton!
    let messageButton:UIButton!

    init(source:NSMutableArray) {
        self.source = source
        self.user = source[0] as! MineModel
        returnButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        messageButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var w = self.view.frame.width
        var h = self.view.frame.height
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.itemSize = CGSizeMake(w/3-2, w/3-2)
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Vertical
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 1, 0, 1)
        //设置每行最小间距
        flowLayout.minimumLineSpacing = 2
        //设置每列最小间距
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.headerReferenceSize = CGSizeMake(w,385)
        
        self.floorResultCollectionView = UICollectionView(frame: CGRectMake(0, 0, w, h), collectionViewLayout: flowLayout)
        self.floorResultCollectionView.backgroundColor = UIColor.whiteColor()
        self.floorResultCollectionView.alwaysBounceVertical = true
        self.floorResultCollectionView.delegate = self
        self.floorResultCollectionView.dataSource = self
        self.view.addSubview(self.floorResultCollectionView)
        self.floorResultCollectionView.registerClass(MinePageCollectionViewCell.self, forCellWithReuseIdentifier: "MinePageCollectionViewCell")
        
        self.floorResultCollectionView.registerClass(MinePageHeaderView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        

        
        returnButton.frame =  CGRect(x: 10, y: 30, width: 20, height: 20)
        returnButton.setBackgroundImage(UIImage(named:"btn_back_white"), forState: UIControlState.Normal)
        returnButton.addTarget(self, action: "returnButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        
        messageButton.frame =  CGRect(x: w-35, y: 30, width: 20, height: 20)
        messageButton.setBackgroundImage(UIImage(named:"btn_tips"), forState: UIControlState.Normal)
        messageButton.addTarget(self, action: "toChatController:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        
        self.view.addSubview(messageButton)
        self.view.addSubview(returnButton)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        let w = self.view.frame.width
        let stoty = storys[row] as! UserPage
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MinePageCollectionViewCell", forIndexPath: indexPath) as! MinePageCollectionViewCell
        let imagePath = document.queryImageUrl(stoty.imageUrl)
        if imagePath != nil {
            cell.setData(UIImage(contentsOfFile:imagePath)!)
        }else{
            cell.imageView.image = nil
            cell.request = Alamofire.request(.GET,stoty.imageUrl).response{(req,_,data,error) -> Void in
                if let d = data as? NSData{
                    if error == nil{
                        if req.URLString == cell.request?.request.URLString{
                           cell.setData(UIImage(data:d)!)
                           document.saveImageToDocumentAndPlist(stoty.imageUrl,imageData:d)
                        }
                    }
                }
            }
        }
        //cell.setData(UIImage(named:"pic_head_big")!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.storys.count
    }
    
    //定义每个UICollectionView 的 margin
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(0, 0,0, 0);
    }
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: NSInteger) -> CGFloat{
    //        return CGFloat(0)
    //    }
    
    //定义每个UICollectionView 的大小
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
//        var w = self.view.frame.width
//        return CGSizeMake(w/3, w/3)
//    }
    
    //UICollectionView被选中时调用的方法
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        let section:Int = indexPath.section
        let row:Int = indexPath.row
        
        println("点击了第\(row)个")
        
        
    }
    
    //返回这个UICollectionView是否可以被选择
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    //定义展示的Section的个数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int{
        return 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func returnButtonClick(sender:UIButton){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func toChatController(sender:UIButton){

        self.dismissViewControllerAnimated(true, completion: nil)
        rootController.changeIndex(3)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        rootController.showOrhideToolbar(false)
        storys = NSMutableArray()
        testSource()
        //loadRemoteData()
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView  {
        let reusableView:MinePageHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! MinePageHeaderView
        
//        let personPath = document.queryImageUrl(user.userPersonBgUrl)
//        let headerPath = document.queryImageUrl(user.userHeaderUrl)
//        if personPath != nil && headerPath != nil {
//             reusableView.setData(user.userName, userNoteString: user.userNote, bgImage: UIImage(contentsOfFile: personPath)!, headImage: UIImage(contentsOfFile: headerPath)!,gzCount: user.gzCount, fsCount: user.fsCount, xhCount: user.xhCount)
//        }else{
//            Alamofire.request(.GET,user.userPersonBgUrl).response{(req,_,data,error) -> Void in
//                if let d = data as? NSData{
//                    if error == nil{
//                        let personBgImage  = UIImage(data:d)!
//                        document.saveImageToDocumentAndPlist(self.user.userPersonBgUrl,imageData:d)
//                        Alamofire.request(.GET,self.user.userHeaderUrl).response{(req2,_,data2,error) -> Void in
//                            if let d = data2 as? NSData{
//                                if error == nil{
//                                    reusableView.setData(self.user.userName, userNoteString: self.user.userNote, bgImage: personBgImage, headImage: UIImage(data:d)!,gzCount: self.user.gzCount, fsCount: self.user.fsCount, xhCount: self.user.xhCount)
//                                    document.saveImageToDocumentAndPlist(self.user.userHeaderUrl,imageData:d)
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
        reusableView.setData(user.userName, userNoteString: user.userNote, bgImage: user.userPersonBgImage, headImage: user.userHeadeImage,gzCount: user.gzCount, fsCount: user.fsCount, xhCount: user.xhCount)
        return reusableView
    }
    
    func testSource(){
       
        let ko1 = UserPage(storyId: 1, imageUrl: "http://d9.yihaodianimg.com/N06/M08/B1/B3/CgQIzlVJrBWAX-i6AABMjyE_qpc41500.jpg", storyType: 1)
        let ko2 = UserPage(storyId: 2, imageUrl: "http://d8.yihaodianimg.com/N07/M0A/92/C3/CgQIz1VIkkyALIa3AABHa6auzzY53700.jpg", storyType: 1)
        let ko3 = UserPage(storyId: 3, imageUrl: "http://d8.yihaodianimg.com/N07/M0A/8E/8E/CgQI0FVHFuiAdRXCAABM3Z_9S3w60200.jpg", storyType: 1)
        let ko4 = UserPage(storyId: 4, imageUrl: "http://d9.yihaodianimg.com/N05/M0A/16/A5/CgQI0lVHFxGAQeEhAABJktDNU_g60200.jpg", storyType: 1)
        let ko5 = UserPage(storyId: 5, imageUrl: "http://d9.yihaodianimg.com/N05/M01/0D/E3/CgQI0lVCJVqACbXIAAA5x73_B7M41300.jpg", storyType: 1)
        let ko6 = UserPage(storyId: 6, imageUrl: "http://d6.yihaodianimg.com/V00/M05/71/D4/CgQDsVUbVbSAbcr8AABBQbfTbIw39900.jpg", storyType: 1)
        let ko7 = UserPage(storyId: 7, imageUrl: "http://d8.yihaodianimg.com/N05/M05/17/10/CgQI01VIMxeAMtwOAABI8scWm9c65600.jpg", storyType: 1)
        let ko8 = UserPage(storyId: 8, imageUrl: "http://d8.yihaodianimg.com/N07/M01/91/78/CgQI0FVIXuGAIeZlAAA0zs1ngPc29400.jpg", storyType: 1)
        let ko9 = UserPage(storyId: 9, imageUrl: "http://d7.yihaodianimg.com/N07/M04/88/02/CgQI0FVB7eWAXIJQAAAtldjRB8Q46900.jpg", storyType: 1)
        let ko10 = UserPage(storyId: 10, imageUrl: "http://d7.yihaodianimg.com/N05/M09/1A/14/CgQI0lVIOQuAPtd_AAAcEvmkHOA356.jpg", storyType: 1)
        let ko11 = UserPage(storyId: 11, imageUrl: "http://d9.yihaodianimg.com/N06/M09/AE/F6/CgQIzVVJhwWAdCHVAAAw8r_tT9k30900.jpg", storyType: 1)
        let ko12 = UserPage(storyId: 12, imageUrl: "http://d6.yihaodianimg.com/N06/M0B/A4/30/CgQIzVVG1YGAdm5iAAA2v--MRDU81500.jpg", storyType: 1)
        
        
        self.storys.addObject(ko1)
        self.storys.addObject(ko2)
        self.storys.addObject(ko3)
        self.storys.addObject(ko4)
        self.storys.addObject(ko5)
        self.storys.addObject(ko6)
        self.storys.addObject(ko7)
        self.storys.addObject(ko8)
        self.storys.addObject(ko9)
        self.storys.addObject(ko10)
        self.storys.addObject(ko11)
        self.storys.addObject(ko12)
        
         self.floorResultCollectionView.reloadData()
    }
    
    func loadRemoteData(){
        
        Alamofire.request(.POST, "http://192.168.82.108/api/user/getUserInfo", parameters: ["params":"{'id':'\(user.userId)'}"]).responseJSON {
            (_,_,json,error) -> Void in
            if error == nil {dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
                if let j = json as? NSDictionary {
                    var msg: String = j.valueForKey("code") as! String
                    if(msg == "100"){
                        var s:NSArray = j.valueForKey("body") as! NSArray
                        for ap in s{
                            let ko = UserPage(storyId: ap["storyId"] as! Int, imageUrl: ap["imageUrl"] as! String, storyType: ap["storyType"] as! Int)
                            self.storys.addObject(ko)
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.floorResultCollectionView.reloadData()
                        })
                    }
                }
            })
            }
        }
    }
}
