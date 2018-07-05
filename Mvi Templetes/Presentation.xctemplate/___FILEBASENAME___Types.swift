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

// MARK: - Intent
enum ___VARIABLE_productName:identifier___Intent: MviIntent, AutoDumpable, AutoCases {
    case initial
    case viewWillAppear
    case viewWillDisappear
}

// MARK: - Action
enum ___VARIABLE_productName:identifier___Action: MviAction, AutoDumpable, AutoCases {
    case skipMe
}

// MARK: - Result
protocol ___VARIABLE_productName:identifier___Result: MviResult, AutoDumpable {
}
enum ___VARIABLE_productName:identifier___RetentionResult: ___VARIABLE_productName:identifier___Result, AutoDumpable, AutoCases {
    case dummy
}
enum ___VARIABLE_productName:identifier___DisposableResult: ___VARIABLE_productName:identifier___Result, AutoDumpable, AutoCases {
    case dummy
}

// MARK: - State
struct ___VARIABLE_productName:identifier___State: MviState, Equatable, AutoDumpable {
    
    static func `default`() -> ___VARIABLE_productName:identifier___State {
        return ___VARIABLE_productName:identifier___State()
    }
}

// MARK: - Task
struct ___VARIABLE_productName:identifier___Task: MviTask, Equatable, AutoDumpable {
    
    static func `default`() -> ___VARIABLE_productName:identifier___Task {
        return ___VARIABLE_productName:identifier___Task()
    }
}

//enum ___VARIABLE_productName:identifier___Transition: Equatable, AutoCases {
//}

//struct ___VARIABLE_productName:identifier___Data: Equatable {
//}
