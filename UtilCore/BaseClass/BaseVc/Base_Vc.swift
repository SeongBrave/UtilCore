//
//  BaseVc.swift
//  ShopApp
//
//  Created by eme on 16/6/8.
//  Copyright © 2016年 eme. All rights reserved.
//

import UIKit
import ModelProtocol
import RxSwift

open class Base_Vc: UIViewController {
    
    public var disposeBag = DisposeBag()
    
    public lazy var errorPageView: ErrorPageView = {
        let view = ErrorPageView()
        view.tag = UtilCore.ErrorPageViewTag
        return view
    }()
    
    public func showErrorPage(_ isHiden:Bool) {
        self.errorPageView.isHidden = isHiden
    }
    
    
    open override  func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        /// 界面主题设置
        self.setViewTheme()
        /// 绑定到viewmodel 设置
        self.bindToViewModel()
        
    }
    
    open override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override  func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    open override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     自定义leftBarButtonItem
     */
    open func customLeftBarButtonItem()  {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconfontback"), style: .plain, target: self, action: #selector(backToView))
    }
    /**
     自定义返回上级界面
     */
    @objc open  func backToView()  {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /**
     界面基础设置
     */
    open func setupUI() {
        
    }
    /**
     app 主题 设置
     */
    open func setViewTheme(){
        
    }
    /**
     绑定到viewmodel 设置
     */
    open func bindToViewModel(){
        
    }
}
