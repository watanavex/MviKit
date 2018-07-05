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

public class MviViewModel<I, S, T, A, R, RR, DR>: MviViewModelProtocol where I: MviIntent, S: MviState, A: MviAction, R: MviResult, RR: MviRetentionResult, DR: MviDisposableResult {
    public typealias Intent = I
    public typealias State = S
    public typealias Task = T
    public typealias Action = A
    public typealias Result = R
    public typealias RetentionResult = RR
    public typealias DisposableResult = DR
    
    private let intentsSubject = PublishSubject<Intent>()
    let processor: AnyProcessor<Action, Result>
    let disposeBag = DisposeBag()
    
    private lazy var result: Observable<Result> = {
        return self.resultObservable(intentsSubject: self.intentsSubject)
    }()
    public lazy var state: Observable<State> = {
        return self.stateObservable(resultObservable: self.result)
    }()
    public lazy var task: Observable<Task> = {
        return self.taskObservable(resultObservable: self.result)
    }()
    
    private func resultObservable(intentsSubject: PublishSubject<Intent>) -> Observable<Result> {
        let connectable = intentsSubject
            .compose(self.intentFilter())
            .map(self.actionFrom)
            .flatMap(self.processor.process)
            .publish()
        connectable.connect().disposed(by: self.disposeBag)
        return connectable
    }
    private func stateObservable(resultObservable: Observable<Result>) -> Observable<State> {
        let connectable = resultObservable.filter { $0 is RetentionResult }
            .map { $0 as! RetentionResult }
            .scan(State.default(), accumulator: self.reducer)
            .distinctUntilChanged()
            .replay(1)
        connectable.connect().disposed(by: self.disposeBag)
        return connectable
    }
    private func taskObservable(resultObservable: Observable<Result>) -> Observable<Task> {
        let connectable = resultObservable.filter { $0 is DisposableResult }
            .map { $0 as! DisposableResult }
            .map(self.taskFrom)
            .publish()
        
        connectable.connect().disposed(by: self.disposeBag)
        return connectable
    }
    
    // MARK: - Initializer
    public init(processor: AnyProcessor<Action, Result>) {
        self.processor = processor
    }
    
    // MARK: - Public functions
    public func process(intents: Observable<Intent>) {
        _ = intents.subscribe(self.intentsSubject)
    }
    
    public func intentFilter() -> ComposeTransformer<Intent, Intent> {
        fatalError()
    }
    
    public func actionFrom(intent: Intent) -> Action {
        fatalError()
    }
    
    public func taskFrom(result: DisposableResult) -> Task {
        fatalError()
    }
    
    public func reducer(previousState: State, result: RetentionResult) -> State {
        fatalError()
    }
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
