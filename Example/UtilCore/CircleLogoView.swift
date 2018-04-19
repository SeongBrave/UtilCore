//
//  CircleLogoView.swift
//  UtilCore_Example
//
//  Created by eme on 2018/4/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

/**
 自定义旋转logo 动画
 */
public class CircleLogoView: UIView {
    var radius:CGFloat = 28
    ///外层⭕️图片
    public  let circleImgV = UIImageView(image: UIImage(named: "animation-circle", in: nil, compatibleWith: nil))
    /// 中间的logo图片
    public let logoImgV = UIImageView(image: UIImage(named: "animation-logo", in: nil, compatibleWith: nil))
    ///每秒转的圈数
    public  var circleByOneSecond:Double = 3.0
    func setupSubviews() {
        self.backgroundColor = UIColor.clear
        self.addSubview(logoImgV)
        logoImgV.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(self.radius)
            make.height.equalTo(self.radius)
        }
        self.addSubview(circleImgV)
        circleImgV.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(self.radius)
            make.height.equalTo(self.radius)
        }
        
        ///启动动画
        self.startAnimation()
    }
    func startAnimation()  {
        UIView.animate(withDuration: 1.0/self.circleByOneSecond, delay: 0, options: .curveLinear, animations: {
            self.circleImgV.transform = self.circleImgV.transform.rotated(by: CGFloat(Double.pi/2))
        }){ _ in
            self.startAnimation()
        }
    }
    public convenience init(_ radius:CGFloat) {
        self.init()
        self.radius = radius
        setupSubviews()
    }
    open override func awakeFromNib() {
        setupSubviews()
    }
    open override func draw(_ rect: CGRect) {
        
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required  init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

