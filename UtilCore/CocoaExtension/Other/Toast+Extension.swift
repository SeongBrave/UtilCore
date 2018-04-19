//
//  Toast+Extension.swift
//  Pods
//
//  Created by Icy on 2017/1/10.
//
//


import Foundation
import Toast_Swift
import RxCocoa
import RxSwift
import ModelProtocol
import URLNavigator

extension UIView {
    /**
     一般的弹出显示信息
     */
    public func toast(_ message: String){
        
        self.makeToast(message, duration: 2.0, position:.center)
    }
    /**
     一般的弹出显示信息
     通过错误弹出提示框
     */
    public func toastErrorCode(_ errorCode: Int){
        self.toast(UtilCore.alertmsg[errorCode]?.msgtitle ?? "")
    
    }
    /**
     显示中间提示
     */
    public func toastCenter(_ message: String){
    
        self.makeToast(message, duration: 2.0, position:.center)
    }
    /**
    显示中间提示
     通过错误弹出提示框
     */
    public func toastCenterErrorCode(_ errorCode: Int){
        self.toastCenter(UtilCore.alertmsg[errorCode]?.msgtitle ?? "")
        
    }
    /**
     显示底部提示
     */
    public func toastBottom(_ message: String){
        self.makeToast(message, duration: 2.0, position: .bottom)
    }
    /**
     显示中间提示
     通过错误弹出提示框
     */
    public func toastBottomErrorCode(_ errorCode: Int){
        self.toastBottom(UtilCore.alertmsg[errorCode]?.msgtitle ?? "")
        
    }
    /**
     提示框消失后回调
     - parameter message:
     - parameter completion: 回调函数
     */
    public func toastCompletion(_ message:String,position:ToastPosition = .center,completion: ((_ didTap: Bool) -> Void)?) {
        self.makeToast(message, duration: 2.0, position: position, title: nil, image: nil, completion: completion)
    }
    /**
     通过 mikerError 显示错误信息
     202024： 请登录后再操作
     - parameter error:
     */
    public func toastError(_ error:MikerError){
        if error.code == UtilCore.sharedInstance.toLoginErrorCode {
            self.toastCompletion(error.message){ _ in
                /**
                 *  在这块 就是跳转到登陆模块,如果已经跳转就不需要直接忽略 否则 先将AppData.sharedInstance.isHasToLoginVc改为true然后再跳转
                 */
                if UtilCore.sharedInstance.isHasToLoginVc == false {
                    _ = "login".openURL()
                }
            }
        }else if error.code == UtilCore.sharedInstance.toForcedupdatingErrorCode{
            /*
            表示版本强制更新
             */
            if UtilCore.sharedInstance.isHasForcedupdating == false {
                UtilCore.sharedInstance.isHasForcedupdating = true
                _ = "forcedupdating".openURL(["message":error.message])
            }
            
        }else{
            if UtilCore.sharedInstance.isDebug {
                self.toast(error.message)
            }else{
                 ///表示是生产模式
                let code = "\(error.code)"
                if code.hasPrefix("2") {
                    self.toast(error.message)
                }else{
                    self.toast(UtilCore.sharedInstance.errorMsg)
                }
            }
        }
    }
    /**
     通过 mikerError 显示错误信息
     - parameter error:
     */
    public func toastErrorCompletion(_ error:MikerError,completion: ((_ didTap: Bool) -> Void)?){
        if error.code == UtilCore.sharedInstance.toLoginErrorCode {
            self.toastCompletion(error.message, completion: completion)
        }else{
            if UtilCore.sharedInstance.isDebug {
                self.toastCompletion(error.message, completion: completion)
            }else{
                ///表示是生产模式
                let code = "\(error.code)"
                if code.hasPrefix("2") {
                    self.toastCompletion(error.message, completion: completion)
                }else{
                    self.toastCompletion(UtilCore.sharedInstance.errorMsg, completion: completion)
                }
            }
        }
    }
}
extension UIView{
    /// 绑定rx 可以通过信号显示错误信息
   public var rx_error: AnyObserver<MikerError> {
    return Binder(self) { view, error in
            view.toastError(error)
            }.asObserver()
    }
}
extension Base_Vc{
    /// 绑定 rx  如果网络错误之后 弹出错误界面
    public var rx_showerrorpage: AnyObserver<MikerError> {
        return Binder(self) { baseVc, error in
            let code = "\(error.code)"
            if code.hasPrefix("2") {
                baseVc.view.toastError(error)
            }else{
                var errorMsg = error.message
                /// code 小于0 一般为 没有可用的网络
                if error.code == -1009 {
                    errorMsg = "没有可用的网络"
                }
                if let emptyView = baseVc.view.viewWithTag(UtilCore.ErrorPageViewTag) as? ErrorPageView {
                    emptyView.isHidden = false
                    emptyView.errorStr = errorMsg
                }else{
                    baseVc.errorPageView.frame = CGRect(x: 0, y: 0, width: baseVc.view.frame.width, height: baseVc.view.frame.height)
                    baseVc.errorPageView.errorStr = errorMsg
                    baseVc.errorPageView.isHidden = false
                    self.view.addSubview(self.errorPageView)
                }
            }
            }.asObserver()
    }
    
}
