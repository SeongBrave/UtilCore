//
//  UIStoryboard+Storyboards.swift
//  AHStoryboard
//
//  Created by Andyy Hope on 19/01/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

/*demo: let storyboard = UIStoryboard(storyboard: .News)
 let viewController: ArticleViewController = storyboard.instantiateViewController()
 */
import UIKit

public extension UIStoryboard {
    
    /// The uniform place where we state all the storyboard we have in our application
    
    public enum Storyboard : String {
        case Main
        case Other
        case LoginCore
    }
    
    
    /// Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    
    /// Class Functions
    
    public  class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    
    /// View Controller Instantiation from Generics
    /// Old Way:
    
    public  func instantiateViewController<T: Base_Vc>(_: T.Type) -> T  {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
    
    /// New Way
    public func instantiateViewController<T: Base_Vc>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
    /// 通过枚举类型 加载模块中的类
    static public func instantiateViewController<T: Base_Vc>(storyboard: Storyboard) -> T {
        let podBundle = Bundle(for: T.self)
        guard let bundleURL = podBundle.url(forResource: storyboard.rawValue, withExtension: "bundle") else {
            fatalError("\(T.storyboardIdentifier) 在 \(storyboard.rawValue) 加载路径失败")
        }
        guard let bundle = Bundle(url: bundleURL) else {
            fatalError("\(T.storyboardIdentifier) 在 \(storyboard.rawValue) 加载路径失败")
        }
        let storyboard = UIStoryboard(storyboard: storyboard,bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
    /// 通过字符串 加载模块中的类
    static public func instantiateViewControllerByStr<T: Base_Vc>(storyboardName:  String) -> T {
        let podBundle = Bundle(for: T.self)
        guard let bundleURL = podBundle.url(forResource: storyboardName, withExtension: "bundle") else {
            fatalError("\(T.storyboardIdentifier) 在 \(storyboardName) 加载路径失败")
        }
        guard let bundle = Bundle(url: bundleURL) else {
            fatalError("\(T.storyboardIdentifier) 在 \(storyboardName) 加载路径失败")
        }
        let storyboard = UIStoryboard(name: storyboardName,bundle: bundle)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
    
}

