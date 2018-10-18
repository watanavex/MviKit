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
    associatedtype Intent: MviIntent
    associatedtype State: MviState

    var state: Observable<State> { get }
    func currentState() -> State
    func process(intents: Observable<Intent>)
}

open class MviViewModel<I, S, A, R>: MviViewModelProtocol where I: MviIntent, S: MviState, A: MviAction, R: MviResult {
    
    public typealias Intent = I
    public typealias State = S
    public typealias Action = A
    public typealias Result = R
    public typealias Processor = AnyProcessor<Action, Result>
    
    private let intentsSubject = PublishSubject<Intent>()
    public let processor: Processor
    let disposeBag = DisposeBag()
    
    private var _currentState: State = State.default()
    public func currentState() -> State {
        return self._currentState
    }

    public lazy var state: Observable<State> = {
        let connectable = self.intentsSubject
            .compose(self.intentFilter())
            .map { [unowned self] in self.actionFrom(intent: $0) }
            .flatMap { [unowned self] in self.processor.process(action: $0) }
            .scan(State.default(), accumulator: { [weak self] (p, r) in
                guard let `self` = self else { return p }
                return self.reducer(previousState: p, result: r)
            })
            .do(onNext: { [weak self] newState in
                self?._currentState = newState
            })
            .distinctUntilChanged()
            .replay(1)
        
        connectable.connect().disposed(by: self.disposeBag)
        return connectable
    }()
    
    // MARK: - Initializer
    public init(processor: Processor) {
        self.processor = processor
    }
    
    // MARK: - Public functions
    open func process(intents: Observable<Intent>) {
        intents.subscribe(self.intentsSubject)
            .disposed(by: self.disposeBag)
    }
    
    // MARK: -
    open func intentFilter() -> ComposeTransformer<Intent, Intent> {
        fatalError()
    }
    
    open func actionFrom(intent: Intent) -> Action {
        fatalError()
    }
    
    open func reducer(previousState: State, result: Result) -> State {
        fatalError()
    }
}

public final class AnyViewModel<I, S>: MviViewModelProtocol where I: MviIntent, S: MviState {

    public typealias Intent = I
    public typealias State = S

    public let state: Observable<State>
    private let _processIntent: (Observable<Intent>)->Void
    private let _currentState: ()->State

    public init<Impl: MviViewModelProtocol>(_ impl: Impl) where Impl.Intent == I, Impl.State == S {
        self.state = impl.state
        self._processIntent = impl.process
        self._currentState = impl.currentState
    }

    public func process(intents: Observable<Intent>) {
        self._processIntent(intents)
    }
    
    public func currentState() -> State {
        return self._currentState()
    }
}
