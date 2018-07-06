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
    associatedtype RetentionResult: MviRetentionResult
    associatedtype DisposableResult: MviDisposableResult

    func process(action: Action) -> Observable<MviResult<RetentionResult, DisposableResult>>
}

open class MviProcessor<A, RR, DR>: MviProcessorProtocol where A: MviAction, RR: MviRetentionResult, DR: MviDisposableResult {

    public typealias Action = A
    public typealias RetentionResult = RR
    public typealias DisposableResult = DR
    public typealias Result = MviResult<RetentionResult, DisposableResult>

    public init() {
    }
    
    open func process(action: Action) -> Observable<Result> {
        return self.execute(action: action)
    }

    open func execute(action: Action) -> Observable<Result> {
        fatalError()
    }
}

public final class AnyProcessor<A, RR, DR>: MviProcessorProtocol where A: MviAction, RR: MviRetentionResult, DR: MviDisposableResult {

    public typealias Action = A
    public typealias Result = MviResult<RR, DR>

    private let _process: (Action)->Observable<Result>

    public init<Impl: MviProcessorProtocol>(_ impl: Impl) where Impl.Action == A, Impl.RetentionResult == RR, Impl.DisposableResult == DR {
        self._process = impl.process
    }

    public func process(action: Action) -> Observable<Result> {
        return self._process(action)
    }
}
