//
//  TextField+Externsion.swift
//  MikerShop
//
//  Created by eme on 2016/11/26.
//  Copyright © 2016年 eme. All rights reserved.
//

import UIKit

extension UITextField {
    ///设置placeholder的字体颜色
    public func changePlaceholder(_ placeholder:String,placeColor:UIColor,textColor:UIColor) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: placeColor]
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes:attributes)
        self.textColor = textColor
    }
}


