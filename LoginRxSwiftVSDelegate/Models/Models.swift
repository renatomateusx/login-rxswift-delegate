//
//  Models.swift
//  LoginRxSwiftVSDelegate
//
//  Created by Renato Mateus on 17/03/21.
//
import UIKit
import Foundation

struct Constants  {
    static let padding: CGFloat = 8
    static let cornerRadius: CGFloat = 8.0
}

struct User: Codable {
    let username: String?
    let email: String?
    let password: String
}

struct UserResult: Codable {
    let result: Bool
}
