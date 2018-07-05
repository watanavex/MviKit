//
//  ObservableType+compose.swift
//  MviKit
//
//  Created by Yohta Watanave on 2018/07/05.
//  Copyright © 2018年 Yohta Watanave. All rights reserved.
//

import Foundation
import RxSwift

protocol ComposeTransformerProtocol {
    associatedtype upstream
    associatedtype downstream
    
    func call(_ observable: Observable<upstream>) -> Observable<downstream>
}

final class ComposeTransformer<T, R>: ComposeTransformerProtocol {
    
    typealias upstream = T
    typealias downstream = R
    
    private let _call: (Observable<T>) -> Observable<R>
    
    init<Impl: ComposeTransformerProtocol>(_ impl: Impl) where Impl.upstream == T, Impl.downstream == R {
        self._call = impl.call
    }
    
    init(transformer: @escaping (Observable<T>) -> Observable<R>) {
        self._call = transformer
    }
    
    func call(_ observable: Observable<T>) -> Observable<R> {
        return self._call(observable)
    }
}

extension ObservableType {
    func compose<T>(_ transformer: ComposeTransformer<E, T>) -> Observable<T> {
        return transformer.call(self.asObservable())
    }
}

