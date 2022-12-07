//
//  SplashViewModelSpec.swift
//  SurveyTests
//
//  Created by Khanh on 16/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
//  swiftlint:disable closure_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SplashViewModelSpec: QuickSpec {

    var userSessionUseCase: UserSessionUseCaseMock!
    var homeUseCase: HomeUseCaseMock!
    var input: SplashViewModel.Input!
    var output: SplashViewModel.Output!

    override func spec() {
        var viewModel: SplashViewModel!
        let loadTrigger = PassthroughSubject<Void, Never>()
        let willFetchSurveysTrigger = PassthroughSubject<Void, Never>()

        describe("a SplashViewModel") {

            beforeEach {
                self.userSessionUseCase = UserSessionUseCaseMock()
                self.homeUseCase = HomeUseCaseMock()
                viewModel = SplashViewModel(
                    userSessionUseCase: self.userSessionUseCase,
                    homeUseCase: self.homeUseCase,
                    // TODO: Add CachedStorageUseCaseMock in part 2
                    cachedStorageUseCase: CachedStorageUseCase()
                )

                self.input = SplashViewModel.Input(
                    loadTrigger: loadTrigger.eraseToAnyPublisher(),
                    willFetchSurveysTrigger: willFetchSurveysTrigger.eraseToAnyPublisher()
                )
                self.output = viewModel.transform(self.input)
            }

            context("when starting app with user logged in") {

                it("returns output hasUserLoggedIn true") {
                    loadTrigger.send()

                    expect(self.userSessionUseCase.hasUserLoggedInCalled) == true
                    expect(self.output.hasUserLoggedIn).toEventually(beTrue())
                }

                it("fetches data and returns output fetchSuccessfully true") {
                    loadTrigger.send()
                    willFetchSurveysTrigger.send()

                    expect(self.userSessionUseCase.hasUserLoggedInCalled) == true
                    expect(self.output.hasUserLoggedIn).toEventually(beTrue())
                    expect(self.homeUseCase.getSurveyListCalled) == true
                    expect(self.output.fetchSuccessfully).toEventually(beTrue())
                }
            }

            context("when starting app with user did not log in") {

                it("returns output hasUserLoggedIn false") {
                    self.userSessionUseCase.hasUserLoggedInReturnValue = Observable.just(false)

                    loadTrigger.send()

                    expect(self.userSessionUseCase.hasUserLoggedInCalled) == true
                    expect(self.output.hasUserLoggedIn).toEventually(beFalse())
                }
            }
        }
    }
}
