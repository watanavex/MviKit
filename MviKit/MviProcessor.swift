//
//  MviProcessor.swift
//  MviKit
//
//  Created by Yohta Watanave on 2018/07/05.
//  Copyright © 2018年 Yohta Watanave. All rights reserved.
//

import Foundation
import RxSwift

protocol MviProcessorProtocol {
    associatedtype Action
    associatedtype Result
    
    func process(action: Action) -> Observable<Result>
}

final class AnyProcessor<A, R>: MviProcessorProtocol {
    
    typealias Action = A
    typealias Result = R
    
    private let _process: (Action)->Observable<Result>
    
    init<Impl: MviProcessorProtocol>(_ impl: Impl) where Impl.Action == A, Impl.Result == R {
        self._process = impl.process
    }
    
    func process(action: Action) -> Observable<Result> {
        return self._process(action)
    }
}
