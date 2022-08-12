//
//  LoginFlowSpec.swift
//  Survey
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Nimble
import Quick
import XCTest

class LoginFlowSpec: QuickSpec {

    override func spec() {
        var app: XCUIApplication!

        describe("a Survey app") {

            context("when go through login flow successfully") {

                beforeEach {
                    self.continueAfterFailure = false

                    app = XCUIApplication()
                    app.launch()

                    app.textFields[TestConstants.Login.emailInputTextField]
                        .tapThen()
                        .typeText("nkhanh44@nimblehq.co")
                    app.secureTextFields[TestConstants.Login.passwordInputTextField]
                        .tapThen()
                        .typeText("12345678")
                    app.buttons[TestConstants.Login.loginButton]
                        .tap()
                }

                it("shows Home screen") {
                    let buttonExists = app.scrollViews[TestConstants.Home.scrollView].waitForExistence(timeout: 5)
                    expect(buttonExists).toEventually(beTrue())
                }
            }
        }
    }
}
