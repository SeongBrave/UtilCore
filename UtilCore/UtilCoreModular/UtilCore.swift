//
//  UtilCore.swift
//  Pods
//
//  Created by eme on 2017/1/6.
//
//

import Foundation
import SwiftyUserDefaults
import ModelProtocol
import NVActivityIndicatorView

/// 本模块的名称， 本模块的storyboard 名称必须 与模块名称相同 ,已经用于静态资源的加载回用到
let modularName = "UtilCore"

public  class UtilCore {
    public static var sharedInstance : UtilCore {
        struct Static {
            static let instance : UtilCore = UtilCore()
        }
        let utilCore = Static.instance
        utilCore.update()
        return utilCore
    }
    ///用于提供弹出信息
    static public var alertmsg:Dictionary<Int,(msgcode:Int,msgtitle:String,msginfo:String)>{
        get{
            for dict  in UtilCore.msg {
                alert_msg[dict.0] = dict.1
            }
            return alert_msg
        }
        set (newValue){
            UtilCore.msg = newValue
        }
    }
    /// 登陆模块的storyboard
    public static var storyboard:UIStoryboard{
        get{
            return UIStoryboard(name: modularName, bundle: UtilCore.bundle)
        }
    }
    /// 模块中的 扫一扫vc
    public static var scanVc:Scan_Vc{
        get{
            return UtilCore.storyboard.instantiateViewController(withIdentifier: "Scan_Vc") as! Scan_Vc
        }
    }
    ///供其他模块使用
    public static var bundle:Bundle?{
        get{
            guard let bundleURL = Bundle(for: Scan_Vc.self).url(forResource: modularName, withExtension: "bundle") else {
                return nil
            }
            guard let bundle = Bundle(url: bundleURL) else {
                return nil
            }
            return bundle
        }
        
    }
    ///弹出网络错误view的 tag
    public static var ErrorPageViewTag = 1000102
    /// 基础网络地址
    public var baseUrl:String = ""
    /// 字体类型
    public var fontName:String = "Helvetica"
    ///表示是否是debug模式
    public var isDebug:Bool = true
    ///需要重新登录的错误码
    public var toLoginErrorCode:Int = 500101
    ///500102：表示版本强制更新
    public var toForcedupdatingErrorCode:Int = 500102
    /*
     说明:该参数是用于 当返回状态码‘500103请登录后再操作’的时候 跳转到登陆界面， 防止重复跳转的问题
     1、是否已经跳转到登陆模块
     */
    public  var isHasToLoginVc:Bool = false
    /*
     说明:用于返回状态为`500102`强制版本更新 如果已经弹出alert 则不需要再次弹出
     */
    public var isHasForcedupdating:Bool = false
    ///用于加到webview 的header中，缓存用户信息
    public  var activeid:String = ""
    /// 服务端用于获取的字段id
    public  var fieldValue:String = "activeid"
    
    
    ///用于在H5调用"getactivedata"方法时传入的数据
    public var activeData:[String:Any] = [:]
    
    ///生产模式时所有非2开头的错误 码显示错误的信息
    public var errorMsg:String = "网络错误"
    /// 提示错误码
    static private var msg:Dictionary<Int,(msgcode:Int,msgtitle:String,msginfo:String)> = [:]
    /// 加载动画的背景颜色
    static public var loadingBgColor:UIColor = UIColor(hex: "c0c0c0")
    /// 加载动画的视图view
    static public var loadingView:loadingType = loadingType.activityIndicatorType(type: .ballSpinFadeLoader)
    
    
    func update() -> Void {
        guard let path = Bundle.main.path(forResource: "UtilCore", ofType: "plist") else {
            return
        }
        guard let dict = NSDictionary(contentsOfFile:path) else {
            return
        }
        if let baseurl = dict["baseurl"] as? String {
            self.baseUrl = baseurl
        }
        if let fontname = dict["fontname"] as? String {
            self.fontName = fontname
        }
        
    }
}
