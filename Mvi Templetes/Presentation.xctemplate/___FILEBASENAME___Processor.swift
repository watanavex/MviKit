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

protocol ___FILEBASENAMEASIDENTIFIER___Protocol: MviProcessorProtocol where Action == ___VARIABLE_productName:identifier___Action, RetentionResult == ___VARIABLE_productName:identifier___RetentionResult, DisposableResult == ___VARIABLE_productName:identifier___DisposableResult {
}

class ___VARIABLE_productName:identifier___Processor: MviProcessor<___VARIABLE_productName:identifier___Action, ___VARIABLE_productName:identifier___RetentionResult, ___VARIABLE_productName:identifier___DisposableResult> {

    override func execute(action: Action) -> Observable<Result> {
        switch action {
        case .skipMe:
            return Observable.never()
        }
    }
}
