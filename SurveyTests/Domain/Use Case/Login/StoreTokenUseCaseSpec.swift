//
//  StoreTokenUseCaseSpec.swift
//  SurveyTests
//
//  Created by Khanh on 09/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
@testable import Survey

final class StoreTokenUseCaseSpec: QuickSpec {

    override func spec() {

        var storeTokenUseCase: StoreTokenUseCaseMock!
        var keychain: KeychainServiceMock!

        describe("a StoreTokenUseCase") {

            beforeEach {
                keychain = KeychainServiceMock()
                storeTokenUseCase = StoreTokenUseCaseMock()
                let token = APIToken.dummy
                try? keychain.set(newToken: KeychainToken(token: token), for: .token)
            }

            context("when store token is called") {

                beforeEach {
                    _ = storeTokenUseCase.store(token: APIToken.dummy)
                }

                it("returns correct response") {
                    expect(storeTokenUseCase.storeCalled) == true
                    expect(try? keychain.isLoggedIn()) == true
                }
            }
        }
    }
}
