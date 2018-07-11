//
//  MviResult.swift
//  MviKit
//
//  Created by Yohta Watanave on 2018/07/05.
//  Copyright © 2018年 Yohta Watanave. All rights reserved.
//

import Foundation

public enum MviResult<R, D> {
    public typealias RetentionResult = R
    public typealias DisposableResult = D
    
    case retentionResult(_ : RetentionResult)
    case disposableResult(_ : DisposableResult)
    
    public init(_ r: R) {
        self = .retentionResult(r)
    }
    public init(_ d: D) {
        self = .disposableResult(d)
    }
}
public protocol MviRetentionResult { }
public protocol MviDisposableResult { }

extension MviResult {
    public func isRetentionResult() -> Bool {
        if case .retentionResult = self {
            return true
        }
        else {
            return false
        }
    }
    public func isNotRetentionResult() -> Bool {
        return !self.isRetentionResult()
    }
    
    public func isDisposableResult() -> Bool {
        if case .disposableResult = self {
            return true
        }
        else {
            return false
        }
    }
    public func isNotDisposableResult() -> Bool {
        return !self.isDisposableResult()
    }
    
    public static func isRetentionResult(_ `case`: MviResult) -> Bool {
        return `case`.isRetentionResult()
    }
    public static func isNotRetentionResult(_ `case`: MviResult) -> Bool {
        return !`case`.isRetentionResult()
    }
    
    public static func isDisposableResult(_ `case`: MviResult) -> Bool {
        return `case`.isDisposableResult()
    }
    public static func isNotDisposableResult(_ `case`: MviResult) -> Bool {
        return `case`.isNotDisposableResult()
    }
    
    public func getRetentionResult() -> R? {
        switch self {
        case .retentionResult(let r):
            return r
        default:
            return nil
        }
    }
    public func getDisposableResult() -> D? {
        switch self {
        case .disposableResult(let d):
            return d
        default:
            return nil
        }
    }
}
