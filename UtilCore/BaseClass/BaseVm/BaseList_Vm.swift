//
//  BaseList_Vm.swift
//  MikerShop
//
//  Created by eme on 2017/1/6.
//  Copyright © 2017年 eme. All rights reserved.
//

import RxSwift

/*
 owner:cy
 info: 分页vm 的父类
 */
open class BaseList_Vm : Base_Vm {
    
    /*
     通用设置
     */
    /// 下来刷新 上啦加载更多 缓存第几页
    open var page:Int = 0
    
    /// 是否还有下一页
    open let hasNextPage = Variable(true)
    
}
