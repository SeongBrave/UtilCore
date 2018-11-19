//
//  Botton+Externsion.swift
//  ShopApp
//
//  Created by eme on 16/8/17.
//  Copyright © 2016年 eme. All rights reserved.
//

import UIKit
import Kingfisher
extension UIButton {
    /**
     改变button 的imageview 和 title为垂直排列
     
     - parameter offset:
     */
    public func changeEdgeVertical(_ offset:Float) {
        let titleSize = self.titleLabel!.intrinsicContentSize
        let imageSize = self.imageView!.bounds.size
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -imageSize.height - CGFloat(offset / 2), right: 0.0)
        self.imageEdgeInsets = UIEdgeInsets(top: -titleSize.height - CGFloat(offset / 2), left: 0.0, bottom: 0.0, right: -titleSize.width)
    }
    /**
     改变button 的imageview 在title的左侧
     
     - parameter offset:
     */
    public func changeEdgeLeftImage(_ offset:CGFloat) {
        let titleSize = self.titleLabel!.intrinsicContentSize
        let imageSize = self.imageView!.bounds.size
        self.imageEdgeInsets = UIEdgeInsets(top: 0,left: titleSize.width + offset, bottom: 0, right: -(titleSize.width + offset));
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + offset), bottom: 0, right: imageSize.width + offset)
        
    }
    /// 同意修改按钮配置颜色
    public func changeBackgroundImage(_ defaultColor:UIColor,highlightedColor:UIColor ,disabledColor:UIColor ) {
        self.setBackgroundImage(defaultColor.getImage(), for: .normal)
        self.setBackgroundImage(highlightedColor.getImage(), for: .highlighted)
        self.setBackgroundImage(disabledColor.getImage(), for: .disabled)
    }
    /// 通过字符串设置按钮颜色 ， 透明度修改0.3
    public func changeBackgroundImage(_ defaultHex:String,highlightedHex:String ,disabledHex:String ) {
        self.setBackgroundImage(UIColor(hex: defaultHex).getImage(), for: .normal)
        self.setBackgroundImage(UIColor(hex: highlightedHex).getImage(), for: .highlighted)
        self.setBackgroundImage(UIColor(hex: disabledHex).getImage(), for: .disabled)
    }
    /// 通过字符串设置按钮颜色 ， 透明度修改0.3
    public func changeBackgroundImage(_ defaultHex:String) {
        self.setBackgroundImage(UIColor(hex: defaultHex).getImage(), for: .normal)
        self.setBackgroundImage(UIColor(hex: defaultHex ,alpha: 0.3).getImage(), for: .highlighted)
        self.setBackgroundImage(UIColor(hex: defaultHex ,alpha: 0.3).getImage(), for: .disabled)
    }
}
extension UIButton {
    /// 通过key 加载网络图片
    public func setUrlImage(url:String , forState state: UIControl.State = .normal , options:KingfisherOptionsInfo = [.transition(ImageTransition.fade(1.2))]) -> Void {
        self.kf.setImage(with: URL(string: url)! , for: state,options:options)
    }
}
