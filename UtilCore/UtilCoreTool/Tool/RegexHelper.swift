//
//  RegexHelper.swift
//  ShopApp
//
//  Created by eme on 16/7/1.
//  Copyright © 2016年 eme. All rights reserved.
//

import Foundation

struct RegexHelper {
    let regex: NSRegularExpression
    
    init(_ pattern: String) throws {
        try regex = NSRegularExpression(pattern: pattern,
                                        options: .caseInsensitive)
    }
    
    func match(input: String) -> Bool {
        let matches = regex.matches(in: input,
                                            options: [],
                                            range: NSMakeRange(0, input.utf16.count))
        return matches.count > 0
    }
}

infix operator =~ : ATPrecedence
precedencegroup ATPrecedence { //定义运算符优先级ATPrecedence
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

//infix operator =~ {
//associativity none
//precedence 130
//}

public func =~(lhs: String, rhs: String) -> Bool {
    do {
        return try RegexHelper(rhs).match(input: lhs)
    } catch _ {
        return false
    }
}
