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

protocol ___FILEBASENAMEASIDENTIFIER___Protocol: MviProcessorProtocol where Action == ___VARIABLE_productName:identifier___Action, Result == ___VARIABLE_productName:identifier___Result {
}

class ___FILEBASENAMEASIDENTIFIER___: ___FILEBASENAMEASIDENTIFIER___Protocol {

    typealias Action = ___VARIABLE_productName:identifier___Action
    typealias Result = ___VARIABLE_productName:identifier___Result

    func process(action: Action) -> Observable<Result> {
        return self.execute(action: action)
    }
    
    func execute(action: Action) -> Observable<Result> {
//        switch action {
//        }
        return Observable.never()
    }
}
