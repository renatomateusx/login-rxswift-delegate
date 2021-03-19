//
//  LoginRxViewModel.swift
//  LoginRxSwiftVSDelegate
//
//  Created by Renato Mateus on 17/03/21.
//

import RxSwift
import RxCocoa


class LoginRxViewModel: ViewModelProtocol, LoginRx {
    struct Input {
        let email: AnyObserver<String>
        let username: AnyObserver<String>
        let password: AnyObserver<String>
        let loginButton: AnyObserver<Void>
    }
    struct Output {
        let loginResultObservable: Observable<Bool>
        let errorsObservable: Observable<Bool>
    }
    
    let input: Input
    let output: Output
    
    private let emailSubject = BehaviorSubject<String>(value: "")
    private let usernameSubject = BehaviorSubject<String>(value: "")
    private let passwordSubject = BehaviorSubject<String>(value: "")
    private let loginResultSubject = PublishSubject<Bool>()
    private let errorsSubject = PublishSubject<Bool>()
    private let loginButton = PublishSubject<Void>()
    
    init(){
        input = Input(
            email: usernameSubject.asObserver(), username: usernameSubject.asObserver(), password: passwordSubject.asObserver(), loginButton: loginButton.asObserver()
        )
        output = Output(loginResultObservable: loginResultSubject.asObservable(), errorsObservable: errorsSubject.asObservable())
    }
    
    func doLogin() {
        Observable.combineLatest(usernameSubject.asObservable(), passwordSubject.asObservable()) { (email, password)  in
            AuthManager.shared.login(username: email, email: email, password: password) { logged in
                if(logged){
                    self.loginResultSubject.onNext(true)
                }else{
                    self.errorsSubject.onNext(false)
                }
            }
        }.subscribe(onNext: { response in
            print(response)
        }).disposed(by: DisposeBag())
    }    
}
