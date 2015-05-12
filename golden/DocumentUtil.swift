//
//  DocumentUtil.swift
//  golden
//
//  Created by 张立 on 15/5/6.
//  Copyright (c) 2015年 张立. All rights reserved.
//

import UIKit
let User_Plist = "User.plist"
let Image_Plist = "Image.plist"
//沙盒操作类
class DocumentUtil: NSObject {
    
    let user = "USER_ID"
    let Plist = "plist"
    
    
    //保存图片至沙盒并保存图片key value至Image.plist文件
    func saveImageToDocumentAndPlist(imageURL:String,imageData:NSData){
        let fullPath = document.bulidImagePath(document.bulidImageName(imageURL))
        document.saveImageFull(UIImage(data: imageData)!,fullPath: fullPath)
        document.addImageToPlist(imageURL, filePath: fullPath)
    }
    
    
    
    //生成保存至本地的图片名称
    func bulidImageName(imageUrl:String) ->String{
        let spp = imageUrl.componentsSeparatedByString("/")
        return spp[spp.count-1]
    }
    
    //生成图片文件路径
    func bulidImagePath(fileName:String) ->String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(fileName)
        println("\(path)")
        return path
    }
    
    //保存图片至沙盒
    func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, fullPath: String){
        //压缩图片尺寸
        UIGraphicsBeginImageContext(newSize)
        currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //高保真压缩图片质量
        //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
        let imageData: NSData = UIImageJPEGRepresentation(newImage, percent)
        // 将图片写入文件
        imageData.writeToFile(fullPath, atomically: false)
    }
    
    //不压缩图片保存图片
    func saveImageFull(currentImage: UIImage,fullPath: String){
        let imageData: NSData = UIImageJPEGRepresentation(currentImage, 1)
        imageData.writeToFile(fullPath, atomically: false)
    }
    
    //查询沙盒中的图片存储路径，key为图片远程url
    func queryImageUrl(key:String) -> String!{
        let resultDictionary = queryDataOfPlist(Image_Plist)
        if resultDictionary.count != 0 {
            if let x  = resultDictionary.objectForKey(key) as? String{
                return x
            }
        }
        return nil
    }
    
    //保存图片信息至plist中
    func addImageToPlist(url:String,filePath:String) {
        let resultDictionary = queryDataOfPlist(Image_Plist)
        resultDictionary.setObject(filePath, forKey: url)
        saveDataToPlist(Image_Plist,data:resultDictionary)
    }
    
    
    
    
    //判断是否已经登陆
    func haveLogin() -> Bool{
        let resultDictionary = queryDataOfPlist(User_Plist)
        if resultDictionary.count != 0 {
            if let x  = resultDictionary.objectForKey(user) as? String{
                return true
            }
        }
        return false
    }
    
    //保存用户信息到沙盒中
    func saveLoginMessage(userId:String){
        let dic:NSMutableDictionary = [user:userId]
        saveDataToPlist(User_Plist,data:dic)
    }
    

    //在沙盒中创建plist文件
    func createPlist(fileName:String,title:String) ->String{
        let path = returnPlistPath(fileName)
        let fileManager = NSFileManager.defaultManager()
        if(!fileManager.fileExistsAtPath(path)) {
            // 拷贝本地的User.plist文件至沙盒中
            if let bundlePath = NSBundle.mainBundle().pathForResource(title, ofType: Plist) {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
            }
        }
        return path
    }
    
    
    
    
    //保存数据至沙盒
    func saveDataToPlist(fileName:String,data:NSMutableDictionary){
        let title  = fileName.componentsSeparatedByString(".")[0]
        let path = createPlist(fileName,title:title)
        data.writeToFile(path, atomically: false)
        
        printlnDocument(path)
    }
    
    //清空指定沙盒
    func clearDataOfPlist(fileName:String){
        let title  = fileName.componentsSeparatedByString(".")[0]
        let path = createPlist(fileName,title:title)
        var dict: NSMutableDictionary = [:]
        dict.writeToFile(path, atomically: false)
        
        printlnDocument(path)
    }
    
    //查询指定沙盒信息
    func queryDataOfPlist(fileName:String) ->NSMutableDictionary{
        
        let title  = fileName.componentsSeparatedByString(".")[0]
        let path = createPlist(fileName,title:title)
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        //if let dict = resultDictionary {
            if resultDictionary?.count != 0 {
                return resultDictionary!
            }
        //}
        return [:]
    }
    
    
    //返回沙盒目录
    func returnPlistPath(fileName:String) -> String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent(fileName)
        return path
    }
    
    
    func printlnDocument(path:String){
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Loaded plist file is --> \(resultDictionary?.description)")
    }
    
}
