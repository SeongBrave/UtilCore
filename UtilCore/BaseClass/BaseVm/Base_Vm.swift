//
//  Base_Vm.swift
//  Pods
//
//  Created by Icy on 2017/1/4.
//
//

import RxSwift
import ModelProtocol
import SwiftyJSON

/*
 owner:cy
 info: 基础父类
 */
open class Base_Vm {
    
    /// 保存错误
    open let error = PublishSubject<MikerError>()
    open let disposeBag = DisposeBag()
    /// 断网重新加载
    open let reloadTrigger = PublishSubject<Void>()
    ///主要用于 列表的刷新 不是上啦加载更多时 如果出错则会弹出 错误界面
    open let refresherror = PublishSubject<MikerError>()
    
    public init() {
        
    }
}
