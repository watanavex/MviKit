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
}
public protocol MviRetentionResult { }
public protocol MviDisposableResult { }
