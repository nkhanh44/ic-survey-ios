//
//  UserSessionUseCaseSpec.swift
//  SurveyTests
//
//  Created by Khanh on 16/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
@testable import Survey

final class UserSessionUseCaseSpec: QuickSpec {

    override func spec() {
        var useCase: UserSessionUseCase!
        var keychain: KeychainServiceMock!

        describe("a UserSessionUseCase") {

            beforeEach {
                keychain = KeychainServiceMock()
                useCase = UserSessionUseCase(keychain: keychain)
                let token = APIToken.dummy
                try? keychain.set(newToken: KeychainToken(token: token), for: .token)
            }

            context("when hasUserLoggedIn is called") {

                beforeEach {
                    _ = useCase.hasUserLoggedIn()
                }

                it("returns correct response") {
                    expect(try? keychain.isLoggedIn()) == true
                }
            }
        }
    }
}
