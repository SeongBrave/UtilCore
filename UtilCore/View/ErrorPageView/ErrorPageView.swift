//
//  ErrorPageView.swift
//  Pods
//
//  Created by eme on 2017/3/17.
//
//

import UIKit
import SnapKit
import RxSwift

/// 网络错误等断网提示的界面
open class ErrorPageView: UIView {
    
    /// UI控件
    var error_ImgV = UIImageView()
    var error_Lb = UILabel()
    var reload_Btn = UIButton(type: .custom)
    let disposeBag = DisposeBag()
    ///重新加载的事件
    public let reloadSubject = PublishSubject<Void>()
    
    public var errorStr:String! = "不好意思加载失败了"{
        didSet{
            self.error_Lb.text = errorStr
        }
    }
    public  var reloadBtnStr:String! = "再试试"{
        didSet{
            self.reload_Btn.setTitle(reloadBtnStr, for: .normal)
        }
    }
    public  var errorImgStr:String! = "nonetwork"{
        didSet{
            self.error_ImgV.image = UIImage(named: errorImgStr)
        }
    }
    private let imgStr:String! = "nonetwork"
    
    func setupSubviews() {
        self.backgroundColor = UIColor(hex: "ffffff")
        error_ImgV.image = UIImage(named: imgStr, in: UtilCore.bundle, compatibleWith: nil)
        self.addSubview(self.error_ImgV)
        error_Lb.text = errorStr
        error_Lb.textAlignment = .center
        error_Lb.numberOfLines = 0
        error_Lb.font = UIFont(name: "Helvetica", size: 18)
        error_Lb.textColor = .gray
        self.addSubview(self.error_Lb)
        reload_Btn.setTitle(reloadBtnStr, for: .normal)
        reload_Btn.titleLabel?.font = UIFont(name: "Helvetica", size: 14)
        self.addSubview(self.reload_Btn)
        reload_Btn.layer.cornerRadius = 6.0
        reload_Btn.layer.masksToBounds = true
        reload_Btn.backgroundColor = UIColor(hex: "ffffff")
        reload_Btn.setTitleColor(.black, for: .normal)
        reload_Btn.changeBorderColor(.black, cornerRadius: 1,borderWidth:1)
        
        self.reload_Btn.snp.makeConstraints{ make in
            make.width.equalTo(100)
            make.center.equalToSuperview()
            make.height.equalTo(100 * 0.4)
        }
        self.error_Lb.snp.makeConstraints{ make in
            make.leading.greaterThanOrEqualTo(10)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.reload_Btn.snp.top).offset(-60)
        }
        self.error_ImgV.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.width.equalTo(94)
            make.height.equalTo(68)
            make.bottom.equalTo(self.error_Lb.snp.top).offset(-40)
        }
        self.reload_Btn.rx.tap.bind(to: self.reloadSubject).disposed(by: disposeBag)
        
    }
    open override func awakeFromNib() {
        setupSubviews()
    }
    open override func draw(_ rect: CGRect) {
        
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    public required  init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
