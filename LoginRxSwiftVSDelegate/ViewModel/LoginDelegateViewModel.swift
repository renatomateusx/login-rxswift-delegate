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
                
//                if logged {
//                    self.dismiss(animated: true, completion: nil)
//                }
//                else {
//                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                    self.present(alert, animated: true)
//                }
           
            
        }
    }
    
    
}
