//
//  PlaceholderTextView.swift
//  ShopApp
//
//  Created by eme on 16/8/23.
//  Copyright © 2016年 eme. All rights reserved.
//

import Foundation
import SnapKit
import RxSwift

open class PlaceholderTextView : UITextView {
    
    public  let placeholderLabel: UILabel = UILabel()
    @IBInspectable public var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = UIColor(hex: "c7c7cd") {
        didSet {
            
            placeholderLabel.textColor = placeholderColor
        }
    }
    override open var font: UIFont! {
        didSet {
            placeholderLabel.font = font
        }
    }
    
    override open var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
        }
    }
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        commonInit()
    }
    
    func commonInit() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(PlaceholderTextView.textDidChange),
                                               name: NSNotification.Name.UITextViewTextDidChange,
                                               object: nil)
        
        placeholderLabel.font = font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = textAlignment
        placeholderLabel.text = placeholder
        placeholderLabel.numberOfLines = 0
        placeholderLabel.backgroundColor = UIColor.clear
        addSubview(placeholderLabel)
        
        placeholderLabel.snp.makeConstraints{ make in
            make.top.equalTo(5)
            make.left.equalTo(2)
        }
    }
    
    
    override open var text: String! {
        didSet {
            textDidChange()
        }
    }
    @objc func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    
    
}
