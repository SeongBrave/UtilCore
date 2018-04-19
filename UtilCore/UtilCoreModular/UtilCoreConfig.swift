//
//  ModularConfig.swift
//  Pods
//
//  Created by eme on 2017/1/11.
//
//

import Foundation

/*
 项目区别码 : 10开始
 ios android h5 区别码分别为 1 ，2 ， 3 不区别为 0
 模块有：00
 界面层级显示: 1第一级 2第二级 3第三级 以及往下排序
 具体提示 000 开始
 */
var  alert_msg :Dictionary<Int,(msgcode:Int,msgtitle:String,msginfo:String)>
    = [
        100001111 : (msgcode:100001000,msgtitle:"网络错误",msginfo:"在生产模式时吧系统错误码为1的改为提示")
]
