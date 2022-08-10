//
//  LoginUseCaseSpec.swift
//  SurveyTests
//
//  Created by Khanh on 08/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
@testable import Survey

final class LoginUseCaseSpec: QuickSpec {

    var loginRepository: LoginRepositoryMock!

    override func spec() {

        var logInUseCase: LogInUseCase!

        describe("a LoginUseCase") {

            beforeEach {
                self.loginRepository = LoginRepositoryMock()
                logInUseCase = LogInUseCase(loginRepository: self.loginRepository)
            }

            context("when login is called") {

                beforeEach {
                    _ = logInUseCase.login(email: "example@gmail.com", password: "12345678")
                }

                it("returns correct response") {
                    expect(self.loginRepository.loginCalled) == true
                }
            }
        }
    }
}
