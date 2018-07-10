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

class ___FILEBASENAMEASIDENTIFIER___: MviViewModel<___VARIABLE_productName:identifier___Intent, ___VARIABLE_productName:identifier___State, ___VARIABLE_productName:identifier___Task, ___VARIABLE_productName:identifier___Action, ___VARIABLE_productName:identifier___RetentionResult, ___VARIABLE_productName:identifier___DisposableResult> {

    override func intentFilter() -> ComposeTransformer<Intent, Intent> {
        return ComposeTransformer { upstream -> Observable<Intent> in
            let shared = upstream.publish().refCount()
            return Observable<Intent>.merge(
                shared.filter(Intent.isInitial).take(1),
                shared.filter(Intent.isNotInitial)
            )
        }
    }

    override func actionFrom(intent: Intent) -> Action {
        switch intent {
        case .initial: return .skipMe
        case .viewWillAppear: return .skipMe
        case .viewWillDisappear: return .skipMe
        }
    }

    override func taskFrom(result: DisposableResult) -> Task {
        // TODO: 
    }

    override func reducer(previousState: State, result: RetentionResult) -> State {
        var nextState = previousState
        switch result {
        }
        return nextState
    }
}
