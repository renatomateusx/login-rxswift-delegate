//
//  LoginRxSwiftVSDelegateTests.swift
//  LoginRxSwiftVSDelegateTests
//
//  Created by Renato Mateus on 17/03/21.
//

import XCTest
@testable import LoginRxSwiftVSDelegate

class LoginRxSwiftVSDelegateTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testAUthManager() throws {
        AuthManager.shared.login(username: "renatomateusx@gmail.com", email: "renatomateusx@gmail.com", password: "password") { (result) in
            XCTAssertTrue(result)
        }
    }

    func testEmailIsValid() throws {
        let validEmail = "renatomateusx@gmail.com"
        let result = validEmail.isEmail()
        XCTAssertTrue(result)
    }
    
    func testEmailIsInvalid() throws {
        let validEmail = "renatomateusxgmail.com"
        let result = validEmail.isEmail()
        XCTAssertFalse(result)
    }
    
    func testToNoEmail() throws {
        let email = "renatomateusx@gmail.com"
        let result = email.toNoEmail()
        XCTAssertFalse(result.contains("@"))
    }
    
    func testToNoEmailError() throws {
        let email = "renatomateusxgmail.com"
        let result = email.toNoEmail()
        XCTAssertFalse(result.contains("@"))
    }

    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
