//
//  LoginDelegateViewModel.swift
//  LoginRxSwiftVSDelegate
//
//  Created by Renato Mateus on 17/03/21.
//

import Foundation

class LoginDelegateViewModel: LoginDelegate {
    
    weak var delegate: ResultLogin?
    
    func doLogin(user: User) {
        AuthManager.shared.login(username: user.username, email: user.email, password: user.password) { logged in
            self.delegate?.doResult(result: UserResult(result: logged))            
        }
    }
}
