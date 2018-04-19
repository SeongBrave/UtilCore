//
//  String+Externsion.swift
//  ShopApp
//
//  Created by eme on 16/7/18.
//  Copyright © 2016年 eme. All rights reserved.
//

import Foundation
import UIKit
import CryptoSwift

///字符串的处理
extension String {
    public  var length:Int {
        return self.count
    }
    
    public func indexOf(_ target: String) -> Int? {
        
        let range = (self as NSString).range(of: target)
        
        return range.location
        
    }
    public func lastIndexOf(target: String) -> Int? {

        let range = (self as NSString).range(of: target, options: NSString.CompareOptions.backwards)
        return self.length - range.location - 1
        
    }
    public func contains(s: String) -> Bool {
        return (self.range(of: s) != nil) ? true : false
    }
}
// MARK: - 根据文字计算高度
extension String {
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
}
// MARK: -转换汉字为拼音
extension String{
    public func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
}

