//
//  LoginViewSpec.swift
//  SurveyTests
//
//  Created by Khanh on 08/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick

@testable import Survey

final class LoginViewSpec: QuickSpec {

    override func spec() {
        var loginView: LoginView!

        describe("a LoginView") {

            beforeEach {
                loginView = LoginView(
                    viewModel: LoginViewModel(
                        loginUseCase: LoginUseCaseMock(),
                        storeUseCase: StoreTokenUseCaseMock()
                    )
                )
            }

            context("has onAppear called") {

                it("return correct response") {
                    expect(loginView.output.isLoginEnabled) == false
                }
            }
        }
    }
}
