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
enum ___VARIABLE_productName:identifier___Result: MviResult, AutoDumpable, AutoCases {
}

// MARK: - State
struct ___VARIABLE_productName:identifier___State: MviState, Equatable, AutoDumpable {

    static func `default`() -> ___VARIABLE_productName:identifier___State {
        return ___VARIABLE_productName:identifier___State()
    }
}
