//
//  LoginViewModelSpec.swift
//  SurveyTests
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

//  swiftlint:disable function_body_length closure_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class LoginViewModelSpec: QuickSpec {

    var logInUseCase: LoginUseCaseMock!
    var storeTokenUseCase: StoreTokenUseCaseMock!
    var input: LoginViewModel.Input!
    var output: LoginViewModel.Output!

    override func spec() {
        var viewModel: LoginViewModel!
        let logInTrigger = PassthroughSubject<Void, Never>()

        describe("a LoginViewModel") {

            beforeEach {
                self.logInUseCase = LoginUseCaseMock()
                self.storeTokenUseCase = StoreTokenUseCaseMock()
                viewModel = LoginViewModel(loginUseCase: self.logInUseCase, storeUseCase: self.storeTokenUseCase)

                self.input = LoginViewModel.Input(logInTrigger: logInTrigger.eraseToAnyPublisher())
                self.output = viewModel.transform(self.input)
            }

            afterEach {
                viewModel = nil
            }

            context("when login with email and password returns success") {

                it("returns output isLoggedInSuccessfully with true") {
                    self.input.email = "nkhanh44@nimblehq.co"
                    self.input.password = "12345678"

                    logInTrigger.send(())

                    expect(self.logInUseCase.loginCalled) == true
                    expect(self.storeTokenUseCase.storeCalled).toEventually(beTrue())
                    expect(self.output.isLoggedInSuccessfully).toEventually(beTrue())
                }
            }

            context("when login with email and password returns failure with error alert") {

                it("returns output with alert displayed") {
                    self.logInUseCase.loginSuccessfullyReturnValue = .failure(TestError())

                    self.input.email = "nkhanh44@nimblehq.co"
                    self.input.password = "12345678"

                    logInTrigger.send(())

                    expect(self.output.alert).toEventuallyNot(beNil())
                }
            }

            context("when validate email and password fields returns valid") {

                it("returns output with valid email, password and enabled login button ") {
                    self.input.email = "nkhanh44@nimblehq.co"
                    self.input.password = "12345678"

                    expect(self.output.isEmailValid) == true
                    expect(self.output.isPasswordValid) == true
                    expect(self.output.isLoginEnabled) == true
                }
            }

            context("when validate email and password fields returns invalid") {

                it("returns output with invalid password and disabled login button") {
                    self.input.email = "nkhanh44@nimblehq.co"
                    self.input.password = "123"

                    expect(self.output.isEmailValid) == true
                    expect(self.output.isPasswordValid) == false
                    expect(self.output.isLoginEnabled) == false
                }

                it("returns output with invalid email, valid password and disabled login button ") {
                    self.input.email = "nkhanh44nimblehq."
                    self.input.password = "12345678"

                    expect(self.output.isEmailValid) == false
                    expect(self.output.isPasswordValid) == true
                    expect(self.output.isLoginEnabled) == false
                }
            }
        }
    }
}
