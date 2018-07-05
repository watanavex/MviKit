//
//  MviViewModel.swift
//  MviKit
//
//  Created by Yohta Watanave on 2018/07/05.
//  Copyright © 2018年 Yohta Watanave. All rights reserved.
//

import Foundation
import RxSwift

protocol MviViewModelProtocol {
    associatedtype Intent
    associatedtype State
    associatedtype Task
    
    func state() -> Observable<State>
    func task() -> Observable<Task>
    func process(intents: Observable<Intent>)
}

final class AnyViewModel<I, S, T>: MviViewModelProtocol {
    
    typealias Intent = I
    typealias State = S
    typealias Task = T
    
    private let _state: ()->Observable<State>
    private let _task: ()->Observable<Task>
    private let _processIntent: (Observable<Intent>)->Void
    
    init<Impl: MviViewModelProtocol>(_ impl: Impl) where Impl.Intent == I, Impl.State == S, Impl.Task == T {
        self._state = impl.state
        self._processIntent = impl.process
        self._task = impl.task
    }
    
    func state() -> Observable<State> {
        return self._state()
    }
    func process(intents: Observable<Intent>) {
        self._processIntent(intents)
    }
    func task() -> Observable<Task> {
        return self._task()
    }
}
