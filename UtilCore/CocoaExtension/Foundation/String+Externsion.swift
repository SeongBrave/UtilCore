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


extension String {
    
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    public func positionOf(subStr:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:subStr, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
    
    /// 截取 subStr 之后的字符串 到结尾
    /// print("https://common.ofo.com/about/openbike/?http://ofo.so/plate/36237472".subStringAfter(subStr: "plate/")) //36237472
    /// - Parameters:
    ///   - subStr: 固定的字符串之后
    ///   - backwards: 知否从字符串尾部开始搜索
    /// - Returns: 返回截取之后的字符串
    public func subStringAfter(subStr:String, backwards:Bool = false ) -> String{
        let startPos = self.positionOf(subStr: subStr ,backwards: backwards)
        //没有找到就返回全部字符串
        if startPos == -1 {
            return self
        }
        return String(self[(startPos+subStr.count)...])
    }
    /// 从开头截取字符串到  subStr 之前的字符串
    ///
    ///print("https://common.ofo.com/about/openbike/?http://ofo.so/plate/36237472".subStringBefore(subStr: "plate/")) //https://common.ofo.com/about/openbike/?http://ofo.so/
    /// - Parameters:
    ///   - subStr: 固定的字符串之后
    ///   - backwards: 知否从字符串尾部开始搜索
    /// - Returns: 返回截取之后的字符串
    public func subStringBefore(subStr:String, backwards:Bool = false ) -> String{
        let startPos = self.positionOf(subStr: subStr ,backwards: backwards)
        //没有找到就返回全部字符串
        if startPos == -1 {
            return self
        }
        return String(self[..<(startPos)])
    }
    
}

/*
 let text = "Hello world"
 text[...3] // "Hell"
 text[6..<text.count] // world
 text[NSRange(location: 6, length: 3)] // wor
 */
extension String {
    
    /*
     字符串截取
     let str00 = "hello world"
     let str01 = str00[1..<str00.count-1]
     print(str00)
     print(str01)
     */
    public  subscript(value: NSRange) -> Substring {
        return self[value.lowerBound..<value.upperBound]
    }
    
    /*
     闭合截取
     let str00 = "hello world"
     let str01 = str00[1...str00.count]
     */
    public subscript(value: CountableClosedRange<Int>) -> Substring {
        get {
            guard let upperIndex = index(at: value.upperBound) else{
                guard let lowerIndex = index(at: value.lowerBound) else{
                    return self[self.startIndex...self.endIndex]
                }
                return self[lowerIndex...]
            }
            guard let lowerIndex = index(at: value.lowerBound) else{
                /// 这块表示 截取最后一个字母
                if upperIndex >= self.endIndex{
                    return self[self.startIndex...]
                }else{
                    return self[self.startIndex...upperIndex]
                }
            }
            /// 这块表示 截取最后一个字母
            if upperIndex >= self.endIndex{
                return self[lowerIndex...]
            }else{
                return self[lowerIndex...upperIndex]
            }
        }
    }
    /*
     非闭合截取
     let str00 = "hello world"
     let str01 = str00[1..<str00.count]
     */
    public  subscript(value: CountableRange<Int>) -> Substring {
        get {
            guard let upperIndex = index(at: value.upperBound) else{
                guard let lowerIndex = index(at: value.lowerBound) else{
                    return self[self.startIndex..<self.endIndex]
                }
                return self[lowerIndex..<self.endIndex]
            }
            guard let lowerIndex = index(at: value.lowerBound) else{
                return self[self.startIndex..<upperIndex]
            }
            return self[lowerIndex..<upperIndex]
        }
    }
    /*
     非闭合截取
     let str00 = "hello world"
     let str01 = str00[..<str00.count]
     */
    public  subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            guard let index = index(at: value.upperBound) else{
                return self[..<self.endIndex]
            }
            return self[..<index]
        }
    }
    /*
     闭合截取
     let str00 = "hello world"
     let str01 = str00[...str00.count]
     */
    public subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            guard let index = index(at: value.upperBound) else{
                return self[..<self.endIndex]
            }
            return self[...index]
        }
    }
    /*
     闭合截取
     let str00 = "hello world"
     let str01 = str00[3...]
     */
    public  subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            guard let index = index(at: value.lowerBound) else{
                return self[self.startIndex...]
            }
            /// 这块表示 截取最后一个字母
            if index >= self.endIndex{
                return self[self.startIndex...]
            }
            return self[index...]
        }
    }
    func index(at offset: Int) -> String.Index? {
        if self.count < offset {
            return nil
        }
        return index(startIndex, offsetBy: offset)
        
    }
}
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

