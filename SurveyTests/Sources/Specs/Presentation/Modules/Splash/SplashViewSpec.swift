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
        var userSessionUseCase: UserSessionUseCaseMock!
        var homeUseCase: HomeUseCaseMock!
        var splashView: SplashView!

        describe("a SplashView") {

            beforeEach {
                userSessionUseCase = UserSessionUseCaseMock()
                homeUseCase = HomeUseCaseMock()
                splashView = SplashView(
                    viewModel: SplashViewModel(
                        userSessionUseCase: userSessionUseCase,
                        homeUseCase: homeUseCase
                    )
                )
            }

            context("has onAppear called") {

                it("is not loading") {
                    expect(splashView.output.isLoading) == false
                }
            }
        }
    }
}
