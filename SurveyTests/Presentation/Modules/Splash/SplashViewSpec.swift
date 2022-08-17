//
//  SplashViewSpec.swift
//  Survey
//
//  Created by Khanh on 16/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick

@testable import Survey

final class SplashViewSpec: QuickSpec {

    override func spec() {
        var useCase: UserSessionUseCaseMock!

        describe("a SplashView") {

            beforeEach {
                useCase = UserSessionUseCaseMock()
                _ = SplashView(
                    viewModel: SplashViewModel(
                        useCase: useCase
                    )
                )
            }

            context("has checked user session called") {

                it("return correct response") {
                    expect(useCase.hasUserLoggedInCalled) == true
                }
            }
        }
    }
}
