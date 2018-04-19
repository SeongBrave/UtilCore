//
//  Device.swift
//  Pods
//
//  Created by eme on 2017/3/23.
//
//

import Foundation

public enum Size: Int {
    case UnknownSize = 0
    case Screen3_5Inch
    case Screen4Inch
    case Screen4_7Inch
    case Screen5_5Inch
    case Screen7_9Inch
    case Screen9_7Inch
    case Screen12_9Inch
}

public class Device {
    static public var size:Size{
        get{
            let w: Double = Double(UIScreen.main.bounds.width)
            let h: Double = Double(UIScreen.main.bounds.height)
            let screenHeight: Double = max(w, h)
            
            switch screenHeight {
            case 480:
                return Size.Screen3_5Inch
            case 568:
                return Size.Screen4Inch
            case 667:
                return UIScreen.main.scale == 3.0 ? Size.Screen5_5Inch : Size.Screen4_7Inch
            case 736:
                return Size.Screen5_5Inch
            case 1024:
                return Size.Screen9_7Inch
            case 1366:
                return Size.Screen12_9Inch
            default:
                return Size.UnknownSize
            }
        }
    }
    

}
