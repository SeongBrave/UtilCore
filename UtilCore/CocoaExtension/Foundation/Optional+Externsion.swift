//
//  Optional+Externsion.swift
//  UtilCore
//
//  Created by 成勇 on 2018/11/26.
//

import Foundation

/*
 Optional 的扩展
 参考资料: https://swift.gg/2018/11/19/useful-optional-extensions/
 */

extension Optional {
    /// 可选值为空的时候返回 true
    public var isNone: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
    /// 可选值非空返回 true
    public var isSome: Bool {
        return !isNone
    }
}


extension Optional {
    /// 返回可选值或默认值
    /// - 参数: 如果可选值为空，将会默认值
    public func or(_ default: Wrapped) -> Wrapped {
        return self ?? `default`
    }
    
    /// 返回可选值或 `else` 表达式返回的值
    /// 例如. optional.or(else: print("Arrr"))
    public func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 返回可选值或者 `else` 闭包返回的值
    // 例如. optional.or(else: {
    /// ... do a lot of stuff
    /// })
    public func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
    
    /// 当可选值不为空时，返回可选值
    /// 如果为空，抛出异常
    public func or(throw exception: Error) throws -> Wrapped {
        guard let unwrapped = self else { throw exception }
        return unwrapped
    }
}

extension Optional where Wrapped == Error {
    /// 当可选值不为空时，执行 `else`
    public func or(_ else: (Error) -> Void) {
        guard let error = self else { return }
        `else`(error)
    }
}

extension Optional {
    /// 可选值变换返回，如果可选值为空，则返回默认值
    /// - 参数 fn: 映射值的闭包
    /// - 参数 default: 可选值为空时，将作为返回值
    public func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(fn) ?? `default`
    }
    
    /// 可选值变换返回，如果可选值为空，则调用 `else` 闭包
    /// - 参数 fn: 映射值的闭包
    /// - 参数 else: The function to call if the optional is empty
    public func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(fn) ?? `else`()
    }
}

extension Optional {
    ///  当可选值不为空时，解包并返回参数 `optional`
    public func and<B>(_ optional: B?) -> B? {
        guard self != nil else { return nil }
        return optional
    }
    
    /// 解包可选值，当可选值不为空时，执行 `then` 闭包，并返回执行结果
    /// 允许你将多个可选项连接在一起
    public func and<T>(then: (Wrapped) throws -> T?) rethrows -> T? {
        guard let unwrapped = self else { return nil }
        return try then(unwrapped)
    }
    
    /// 将当前可选值与其他可选值组合在一起
    /// 当且仅当两个可选值都不为空时组合成功，否则返回空
    public func zip2<A>(with other: Optional<A>) -> (Wrapped, A)? {
        guard let first = self, let second = other else { return nil }
        return (first, second)
    }
    
    /// 将当前可选值与其他可选值组合在一起
    /// 当且仅当三个可选值都不为空时组合成功，否则返回空
    public func zip3<A, B>(with other: Optional<A>, another: Optional<B>) -> (Wrapped, A, B)? {
        guard let first = self,
            let second = other,
            let third = another else { return nil }
        return (first, second, third)
    }
}

extension Optional {
    /// 当可选值不为空时，执行 `some` 闭包
    public func on(some: () throws -> Void) rethrows {
        if self != nil { try some() }
    }
    
    /// 当可选值为空时，执行 `none` 闭包
    public func on(none: () throws -> Void) rethrows {
        if self == nil { try none() }
    }
}

extension Optional {
    /// 可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    public func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
            predicate(unwrapped) else { return nil }
        return self
    }
    
    /// 可选值不为空时返回，否则 crash
    public func expect(_ message: String) -> Wrapped {
        guard let value = self else { fatalError(message) }
        return value
    }
}
