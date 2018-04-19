//
//  UtilCoreNavigatorMap.swift
//  Pods
//
//  Created by eme on 2017/1/11.
//
//

import UIKit
import URLNavigator
import RxSwift
import RxCocoa

public protocol MkNavProtocol {
    static var scheme:String{get set}
    static var that:NavigatorType?{get set}
}

extension Navigator:MkNavProtocol{
    /**
     用于缓存自己，全局对象只有一个Navigator实例，用于跳转路由
     */
    public static var that: NavigatorType? = nil
    /**
     用于缓存scheme
     */
    public static var scheme = "appscheme"
}

extension String {
    // 为字符串添加scheme
    public  func formatScheme() -> String {
        return "\(Navigator.scheme)://\(self)"
    }
}

public struct UtilCoreNavigatorMap {
    
    
    public static func initialize(navigator: NavigatorType) {
        Navigator.that = navigator
        /// 弹出框
        navigator.handle("alert".formatScheme()){ url, values ,context in
            let title = url.queryParameters["title"]
            let message = url.queryParameters["message"]
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
            navigator.present(alertController)
            return true
        }
        /// 弹出错误提示信息
        navigator.handle("alerterror".formatScheme()){ url, values ,context in
            guard let fromVc = UIViewController.topMost else {
                return false
            }
            let message = url.queryParameters["message"]
            fromVc.view.toast(message ?? "信息错误")
            return true
        }
        /// 跳转到web 界面
        navigator.register("http://<path:_>") { url, values ,context in
            let webVc:Web_Vc = UIStoryboard.instantiateViewControllerByStr(storyboardName: "UtilCore")
            webVc.webUrl = url.urlStringValue
            webVc.webTitle = url.queryParameters["title"]
            if let isshowloading = url.queryParameters["isloading"] ,isshowloading == "0" {
                webVc.isloading = false
            }else{
                webVc.isloading = true
            }
            return webVc
        }
        /// 跳转到web 界面
        navigator.register("https://<path:_>") { url, values ,context in
            let webVc:Web_Vc = UIStoryboard.instantiateViewControllerByStr(storyboardName: "UtilCore")
            webVc.webUrl = url.urlStringValue
            webVc.webTitle = url.queryParameters["title"]
            if let isshowloading = url.queryParameters["isloading"] ,isshowloading == "0" {
                webVc.isloading = false
            }else{
                webVc.isloading = true
            }
            return webVc
        }
        /// 跳转到web 界面
        navigator.register("scanvc".formatScheme()) { url, values ,context in
            let scanVc:Scan_Vc = UIStoryboard.instantiateViewControllerByStr(storyboardName: "UtilCore")
            return scanVc
        }
        
    }
    
}
extension String {
    /// 返回路由路径
    ///
    /// - Parameter param: 请求参数
    public func  getUrlStr(param:[String:String]? = nil) -> String {
        let that = self.removingPercentEncoding ?? self
        let appScheme = Navigator.scheme
        let relUrl = "\(appScheme)://\(that)"
        guard param != nil else {
            return relUrl
        }
        var paramArr:[String] = []
        for (key , value) in param!{
            paramArr.append("\(key)=\(value)")
        }
        let rel = paramArr.joined(separator: "&")
        guard rel.count > 0 else {
            return  relUrl
        }
        return relUrl + "?\(rel)"
    }
    /// 直接通过路径 和参数调整到 界面
    public func openURL( _ param:[String:String]? = nil) -> Bool {
        let that = self.removingPercentEncoding ?? self
        /// 为了使html的文件通用 需要判断是否以http或者https开头
        guard that.hasPrefix("http") || that.hasPrefix("https") || that.hasPrefix("\(Navigator.scheme )://") else {
            var url = ""
            ///如果以 '/'开头则需要加上本服务域名
            if that.hasPrefix("/") {
                url = UtilCore.sharedInstance.baseUrl + that
            }else{
                url = that.getUrlStr(param: param)
            }
            // 首先需要判断跳转的目标是否是界面还是处理事件 如果是界面需要: push 如果是事件则需要用:open
            let isPushed = Navigator.that?.push(url) != nil
            if isPushed {
                return true
            } else {
                return (Navigator.that?.open(url)) ?? false
            }
        }
        // 首先需要判断跳转的目标是否是界面还是处理事件 如果是界面需要: push 如果是事件则需要用:open
        let isPushed = Navigator.that?.push(that) != nil
        if isPushed {
            return true
        } else {
            return (Navigator.that?.open(that)) ?? false
        }
    } 
}
extension UIView{
    /// 跳转url
    public var rx_openUrl: AnyObserver<(uri:String,param:[String:String]?)> {
        return Binder(self) { view, test in
            _ = test.uri.openURL(test.param)
            }.asObserver()
    }
}
/// 弹框提示
///
/// - Parameters:
///   - title:  标题
///   - message: 信息
public func alertMsg(_ title:String = "提示",message:String?) -> Void {
    _ =  "alert".openURL(["title":title,"message":message ?? ""])
}
/// 弹出错误提示框
///
/// - Parameter message:
public func showMsg(_ message:String?) -> Void {
    _ =  "alerterror".openURL(["message":message ?? ""])
}
// 通过状态吗做提示
public func showMsg(_ codeMsg:Int) -> Void {
    showMsg(UtilCore.alertmsg[codeMsg]?.msgtitle ?? "")
}
