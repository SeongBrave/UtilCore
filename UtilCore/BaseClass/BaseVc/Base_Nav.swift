//
//  Base_Nav.swift
//  UtilCore
//
//  Created by seongbrave on 2018/12/22.
//

import UIKit

/// 为了解决自定义返回按钮导致不能滑动问题
public class Base_Nav: UINavigationController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.delegate = self
    }
}

extension Base_Nav : UIGestureRecognizerDelegate {
    
    private func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count < 2 || self.visibleViewController == self.viewControllers[0] {
                return false
            }
        }
        return true
    }
}
