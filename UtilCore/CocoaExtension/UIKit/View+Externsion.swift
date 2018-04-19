//
//  View+Externsion.swift
//  ShopApp
//
//  Created by Icy on 16/8/19.
//  Copyright © 2016年 eme. All rights reserved.
//

import UIKit

extension UIView {
    /**
     为view 设置边框
     - parameter offset:
     */
    public func changeBorderColor(_ color:UIColor,cornerRadius:CGFloat = 6.0,borderWidth:CGFloat = 1.0) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
    }
    /**
     为view 设置边框
     - parameter offset:
     */
    public func changeBorderColorByHex(hex:String,cornerRadius:CGFloat = 6.0,borderWidth:CGFloat = 1.0) {
        self.changeBorderColor(UIColor(hex: hex), cornerRadius: cornerRadius, borderWidth: borderWidth)
    }
}
