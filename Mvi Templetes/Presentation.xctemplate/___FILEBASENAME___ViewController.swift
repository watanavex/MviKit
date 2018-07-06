//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  ___COPYRIGHT___
//

import UIKit
import MviKit
import RxSwift

class ___VARIABLE_productName:identifier___ViewController: UIViewController {

    typealias Intent = ___VARIABLE_productName:identifier___Intent
    typealias State = ___VARIABLE_productName:identifier___State
    typealias Task = ___VARIABLE_productName:identifier___Task

    private let viewModel = ___VARIABLE_productName:identifier___Container.resolver.resolve(AnyViewModel<Intent, State, Task>.self)!
    private let disposeBag = DisposeBag()
    private let intentPublisher = PublishSubject<Intent>()

    private func bind() {
        self.viewModel
            .state
            .asObservable()
            .subscribe(onNext: { [weak self] state in
                self?.render(state: state)
            })
            .disposed(by: self.disposeBag)
        self.viewModel
            .task
            .asObservable()
            .subscribe(onNext: { [weak self] task in
                self?.handler(task: task)
            })
            .disposed(by: self.disposeBag)
        self.viewModel
            .process(intents: self.intents())
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bind()
    }

    // MARK: - Intents
    func intents() -> Observable<Intent> {
        return Observable.merge(
            Observable.just(.initial),
            self.rx.viewWillAppear.map { .viewWillAppear },
            self.rx.viewDidDisappear.map { .viewWillDisappear },
            intentPublisher
        )
    }

    // MARK: - Renders
    func render(state: State) {
    }

    // MARK: - Handler
    func handler(task: Task) {
    }
}
