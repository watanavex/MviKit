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
    typealias Action = ___VARIABLE_productName:identifier___Action
    typealias Result = ___VARIABLE_productName:identifier___Result

    static var resolver: Container = {
        let container = Container()

        container.register(AnyViewModel<Intent, State>.self) { resolver in
            let processor = resolver.resolve(AnyProcessor<Action, Result>.self)!
            return AnyViewModel(___VARIABLE_productName:identifier___ViewModel(processor: processor))
        }
        .inObjectScope(.graph)

        container.register(AnyProcessor<Action, Result>.self) { resolver in
            return AnyProcessor(___VARIABLE_productName:identifier___Processor())
        }
        .inObjectScope(.container)

        return container
    }()

}
