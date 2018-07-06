//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import Foundation
import MviKit
import Swinject

class ___FILEBASENAMEASIDENTIFIER___ {

    typealias Intent = ___VARIABLE_productName:identifier___Intent
    typealias State = ___VARIABLE_productName:identifier___State
    typealias Task = ___VARIABLE_productName:identifier___Task
    typealias Action = ___VARIABLE_productName:identifier___Action
    typealias RetentionResult = ___VARIABLE_productName:identifier___RetentionResult
    typealias DisposableResult = ___VARIABLE_productName:identifier___DisposableResult
    typealias Result = MviResult<RetentionResult, DisposableResult>

    static var resolver: Container = {
        let container = Container()

        container.register(AnyViewModel<Intent, State, Task>.self) { resolver in
            let processor = resolver.resolve(AnyProcessor<Action, RetentionResult, DisposableResult>.self)!
            return AnyViewModel(___VARIABLE_productName:identifier___ViewModel(processor: processor))
        }
        .inObjectScope(.container)

        container.register(AnyProcessor<Action, RetentionResult, DisposableResult>.self) { resolver in
            return AnyProcessor(___VARIABLE_productName:identifier___Processor())
        }
        .inObjectScope(.container)

        return container
    }()

}
