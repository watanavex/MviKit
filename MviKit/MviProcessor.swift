//
//  MviProcessor.swift
//  MviKit
//
//  Created by Yohta Watanave on 2018/07/05.
//  Copyright © 2018年 Yohta Watanave. All rights reserved.
//

import Foundation
import RxSwift

public protocol MviProcessorProtocol {
    associatedtype Action: MviAction
    associatedtype Result: MviResult

    func process(action: Action) -> Observable<Result>
}

open class MviProcessor<A, R>: MviProcessorProtocol where A: MviAction, R: MviResult {

    public typealias Action = A
    public typealias Result = R

    public init() {
    }
    
    open func process(action: Action) -> Observable<Result> {
        return self.execute(action: action)
    }

    open func execute(action: Action) -> Observable<Result> {
        fatalError()
    }
}

public final class AnyProcessor<A, R>: MviProcessorProtocol where A: MviAction, R: MviResult {

    public typealias Action = A
    public typealias Result = R

    private let _process: (Action)->Observable<Result>

    public init<Impl: MviProcessorProtocol>(_ impl: Impl) where Impl.Action == A, Impl.Result == R {
        self._process = impl.process
    }

    public func process(action: Action) -> Observable<Result> {
        return self._process(action)
    }
}
