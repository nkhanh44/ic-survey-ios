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

        var storeTokenUseCase: StoreTokenUseCase!
        var keychain: KeychainService!

        describe("a StoreTokenUseCase") {

            beforeEach {
                keychain = KeychainService(service: "")
                storeTokenUseCase = StoreTokenUseCase(keychain: keychain)
            }

            context("when store token is called") {

                beforeEach {
                    _ = storeTokenUseCase.store(token: APIToken.dummy)
                }

                it("returns correct response") {
                    expect(try? keychain.isLoggedIn()) == true
                }
            }
        }
    }
}
