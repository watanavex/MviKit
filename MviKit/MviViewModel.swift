//
//  MviViewModel.swift
//  MviKit
//
//  Created by Yohta Watanave on 2018/07/05.
//  Copyright © 2018年 Yohta Watanave. All rights reserved.
//

import Foundation
import RxSwift

public protocol MviViewModelProtocol {
    associatedtype Intent
    associatedtype State
    associatedtype Task
    
    var state: Observable<State> { get }
    var task: Observable<Task> { get }
    func process(intents: Observable<Intent>)
}

public final class AnyViewModel<I, S, T>: MviViewModelProtocol {
    
    public typealias Intent = I
    public typealias State = S
    public typealias Task = T
    
    public let state: Observable<State>
    public let task: Observable<Task>
    private let _processIntent: (Observable<Intent>)->Void
    
    public init<Impl: MviViewModelProtocol>(_ impl: Impl) where Impl.Intent == I, Impl.State == S, Impl.Task == T {
        self.state = impl.state
        self.task = impl.task
        self._processIntent = impl.process
    }
    
    public func process(intents: Observable<Intent>) {
        self._processIntent(intents)
    }
}
