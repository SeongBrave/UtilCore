//
//  Label+Extension.swift
//  Pods
//
//  Created by eme on 2017/3/28.
//
//

import Foundation

extension UILabel {
    /// 一个label中有不同颜色的显示文字
    public func setReplaceText(text:String,replace:String? = nil,value:UIColor = UIColor(hex: "e31436"))  {
        //富文本设置
        let attributeString = NSMutableAttributedString(string:text)
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        if let replace  = replace {
            let range = (attributeString.string as NSString).range(of: replace)
            attributeString.addAttributes([NSAttributedStringKey.foregroundColor: value], range: range)
        }
        self.attributedText = attributeString
    }
    /// 设置label的行间距
    public func setLineSpacing(text:String,lineSpacing:CGFloat) {
        let str = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = lineSpacing
        str.addAttribute(NSAttributedStringKey.paragraphStyle, value: style, range: NSRange(location: 0,length: str.length))
        self.attributedText = str
    }
    
}
