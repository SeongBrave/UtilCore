//
//  ViewController.swift
//  UtilCore
//
//  Created by seongbrave on 04/18/2018.
//  Copyright (c) 2018 seongbrave. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import UtilCore
import ModelProtocol

class ViewController: Base_Vc {

    @IBOutlet weak var test_Btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     界面基础设置
     */
    override func setupUI() {
        
        let str:String? = "asdf"
        
        if str.isSome {
            
            print(str.or("asdf"))
            
        }
        
        
    }
    /**
     app 主题 设置
     */
    override func setViewTheme(){
        
    }
    /**
     绑定到viewmodel 设置
     */
    override func bindToViewModel(){
        
//        self.test_Btn
//            .rx.tap
//            .subscribe(onNext: { [unowned self] ( _ ) in
//                /// 表示已经登陆过 之后就不跳转引导界面了
//                self.view.showLoading()
//                let time: TimeInterval = 3.0
//                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
//                    self.view.hideLoading()
//                })
//            })
//            .disposed(by: disposeBag)
        
//        self.test_Btn
//            .rx.tap
//            .map{MikerError("testdomain",code:10010,message:"测试错误信息啊")}
//            .bind(to: self.rx_showerrorpage)
//            .disposed(by: self.disposeBag)
        
//        self.test_Btn
//            .rx.tap
//            .subscribe(onNext: { [unowned self] ( _ ) in
//                self.view.toast("简单弹出框")
//            })
//            .disposed(by: disposeBag)
        
        self.test_Btn
            .rx.tap
            .subscribe(onNext: {  ( _ ) in
                
                _ = "alert".openURL(["title":"标题啊","":"信息呀"])
//                _ = "https://www.jianshu.com/".openURL()
            })
            .disposed(by: disposeBag)
        
        
    }

}



