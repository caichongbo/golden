//
//  extension.swift
//  smartmixer
//
//  Created by 姚俊光 on 14-9-2.
//  Copyright (c) 2014年 Smart Group. All rights reserved.
//
//
import UIKit

//计算文字所占大小
//调用方式：var size = str.textSizeWithFont(self.desc.font, constrainedToSize: CGSize(width:304, height:1000))
extension String {
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if CGSizeEqualToSize(size, CGSizeZero) {
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            textSize = self.sizeWithAttributes(attributes as [NSObject : AnyObject])
        } else {
            let option = NSStringDrawingOptions.UsesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName)
            let stringRect = self.boundingRectWithSize(size, options: option, attributes: attributes as [NSObject : AnyObject], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}
//扩展UIColor属性，16进制颜色转换为UIColor对象
//调用方式 UIColor(rgb: 0x2f8916)
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}