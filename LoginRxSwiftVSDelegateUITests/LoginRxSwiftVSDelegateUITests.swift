//
//  LoginRxSwiftVSDelegateUITests.swift
//  LoginRxSwiftVSDelegateUITests
//
//  Created by Renato Mateus on 17/03/21.
//

import XCTest

class LoginRxSwiftVSDelegateUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()
    }

    override func tearDownWithError() throws {
    }

    func testUserNameTextField() throws {
       
        let usernameTF = self.app.textFields["username"]
        XCTAssert(usernameTF.waitForExistence(timeout: 5))
        XCTAssertTrue(usernameTF.placeholderValue == "Username or Email...")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
