//
//  DelegateProtocol.swift
//  LoginRxSwiftVSDelegate
//
//  Created by Renato Mateus on 17/03/21.
//

import Foundation
protocol LoginDelegate: AnyObject {
    func doLogin(user: User)
}
protocol ResultLogin: AnyObject {
    func doResult(result: UserResult)
}
