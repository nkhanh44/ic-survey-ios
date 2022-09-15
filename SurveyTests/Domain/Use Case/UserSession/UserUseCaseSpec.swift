//
//  UserUseCaseSpec.swift
//  Survey
//
//  Created by Khanh on 13/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
@testable import Survey

final class UserUseCaseSpec: QuickSpec {

    var userRepository: UserRepositoryMock!

    override func spec() {
        var userUseCase: UserUseCase!

        describe("a UserUseCase") {

            beforeEach {
                self.userRepository = UserRepositoryMock()
                userUseCase = UserUseCase(userRepository: self.userRepository)
            }

            context("when getUser is called") {

                beforeEach {
                    _ = userUseCase.getUser()
                }

                it("returns correct response") {
                    expect(self.userRepository.getUserCalled) == true
                }
            }

            context("when logout is called") {

                beforeEach {
                    _ = userUseCase.logout()
                }

                it("returns correct response") {
                    expect(self.userRepository.logoutCalled) == true
                }
            }
        }
    }
}
