//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import MviKit
import RxSwift

protocol ___FILEBASENAMEASIDENTIFIER___Protocol: MviViewModelProtocol where
    Intent == ___VARIABLE_productName:identifier___Intent,
    State == ___VARIABLE_productName:identifier___State,
    Task == ___VARIABLE_productName:identifier___Task { }

class ___FILEBASENAMEASIDENTIFIER___: ___FILEBASENAMEASIDENTIFIER___Protocol {

    typealias Intent = ___VARIABLE_productName:identifier___Intent
    typealias State = ___VARIABLE_productName:identifier___State
    typealias Task = ___VARIABLE_productName:identifier___Task
    
    typealias Action = ___VARIABLE_productName:identifier___Action
    typealias Result = ___VARIABLE_productName:identifier___Result
    typealias RetentionResult = ___VARIABLE_productName:identifier___RetentionResult
    typealias DisposableResult = ___VARIABLE_productName:identifier___DisposableResult
    
    private let intentsSubject = PublishSubject<Intent>()
    let processor: AnyProcessor<Action, Result>
    let disposeBag = DisposeBag()
    
    private lazy var result: Observable<Result> = {
        return self.resultObservable(intentsSubject: self.intentsSubject)
    }()
    lazy var state: Observable<State> = {
        return self.stateObservable(resultObservable: self.result)
    }()
    lazy var task: Observable<Task> = {
        return self.taskObservable(resultObservable: self.result)
    }()
    
    // MARK: - Initializer
    init(processor: AnyProcessor<Action, Result>) {
        self.processor = processor
    }
    
    // MARK: - Public functions
    func process(intents: Observable<Intent>) {
        _ = intents.subscribe(self.intentsSubject)
    }
    
    // MARK: -
    
    func intentFilter() -> ComposeTransformer<Intent, Intent> {
        return ComposeTransformer { upstream -> Observable<Intent> in
            let shared = upstream.publish().refCount()
            return Observable<Intent>.merge(
                shared.filter(Intent.isInitial).take(1),
                shared.filter(Intent.isNotInitial)
            )
        }
    }
    
    func actionFrom(intent: Intent) -> Action {
        switch intent {
        case .initial: return .skipMe
        case .viewWillAppear: return .skipMe
        case .viewWillDisappear: return .skipMe
        }
    }
    
    func taskFrom(result: DisposableResult) -> Task {
        var task = Task.default()
//        switch result {
//        }
        return task
    }
    
    func reducer(previousState: State, result: RetentionResult) -> State {
        var nextState = previousState
//        switch result {
//        }
        return nextState
    }
}
