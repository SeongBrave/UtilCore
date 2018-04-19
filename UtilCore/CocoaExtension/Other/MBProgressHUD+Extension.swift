//
//  MBProgressHUD+Extension.swift
//  Pods
//
//  Created by Icy on 2017/1/10.
//
//

import UIKit
import NVActivityIndicatorView
import RxSwift
import RxCocoa

public enum loadingType {
    ///自定义loadingview
    case customView(loadingView:UIView)
    ///NVActivityIndicatorType类型的view
    case activityIndicatorType(type:NVActivityIndicatorType)
}

extension MBProgressHUD{
    /**
     加载动画
     */
    public static func eme_showHUD(_ view:UIView) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .customView
        hud.bezelView.color = UIColor.clear
        hud.backgroundColor = UIColor.white
        return hud
    }
    public  static func eme_showActivityIndicator(_ view:UIView , type:NVActivityIndicatorType = .ballScaleMultiple) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        let loading = NVActivityIndicatorView(frame: CGRect(x: view.center.x, y: view.center.y, width: 50, height: 50), type:type ,color:UtilCore.loadingBgColor)
        loading.startAnimating()
        hud.mode = .customView
        hud.bezelView.color = UIColor.clear
        hud.customView = loading
        hud.backgroundColor = UIColor.white
        return hud
    }
    
    /// 显示自定义的动画
    ///
    /// - Parameters:
    ///   - view: 在哪个view上显示动画
    ///   - customView: 自定义的动画
    /// - Returns:
    public static func eme_showCustomIndicator(_ view:UIView) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        switch UtilCore.loadingView {
        case let .activityIndicatorType(type):
            let loading = NVActivityIndicatorView(frame: CGRect(x: view.center.x, y: view.center.y, width: 50, height: 50), type:type ,color:UtilCore.loadingBgColor)
            loading.startAnimating()
            hud.mode = .customView
            hud.bezelView.color = UIColor.clear
            hud.customView = loading
            hud.backgroundColor = UIColor.white
            return hud
        case let .customView(loading):
            let subloading = UIView(frame: CGRect(x: view.center.x, y: view.center.y, width: 50, height: 50))
            subloading.addSubview(loading)
            hud.mode = .customView
            hud.bezelView.color = UIColor.clear
            hud.customView = subloading
            hud.backgroundColor = UtilCore.loadingBgColor
            return hud
        }
    }
    /**
     隐藏动画
     */
    public  static func eme_hideHUD(_ view:UIView) -> Bool {
        let subViews = view.subviews.reversed()
        var hud:MBProgressHUD?
        for subView in subViews{
            if subView.isKind(of:MBProgressHUD.self){
                hud = subView as? MBProgressHUD
            }
        }
        if let hud = hud {
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true)
            return true
        }else{
            return false
        }
    }
}
extension UIView{
    public func showLoading() {
        _ = MBProgressHUD.eme_hideHUD(self)
        _ = MBProgressHUD.eme_showCustomIndicator(self)
    }
    public  func hideLoading() {
        _ = MBProgressHUD.eme_hideHUD(self)
    }
    /// 绑定显示进度条
    public var rx_loading: AnyObserver<Bool> {
        return Binder(self) { view, isloading in
            if isloading {
                view.showLoading()
            }else{
                view.hideLoading()
            }
            }.asObserver()
    }
    
}
