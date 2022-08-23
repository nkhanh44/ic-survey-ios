//
//  SplashViewModelSpec.swift
//  SurveyTests
//
//  Created by Khanh on 16/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SplashViewModelSpec: QuickSpec {

    var useCase: UserSessionUseCaseMock!
    var input: SplashViewModel.Input!
    var output: SplashViewModel.Output!

    override func spec() {
        var viewModel: SplashViewModel!
        let loadTrigger = PassthroughSubject<Void, Never>()

        describe("a SplashViewModel") {

            beforeEach {
                self.useCase = UserSessionUseCaseMock()
                viewModel = SplashViewModel(useCase: self.useCase)

                self.input = SplashViewModel.Input(
                    loadTrigger: loadTrigger.eraseToAnyPublisher()
                )
                self.output = viewModel.transform(self.input)
            }

            context("when starting app with user logged in") {

                it("returns output hasUserLoggedIn true") {
                    loadTrigger.send(())

                    expect(self.useCase.hasUserLoggedInCalled) == true
                    expect(self.output.hasUserLoggedIn).toEventually(beTrue())
                }
            }

            context("when starting app with user did not log in") {

                it("returns output hasUserLoggedIn false") {
                    self.useCase.hasUserLoggedInReturnValue = Observable.just(false)

                    loadTrigger.send(())

                    expect(self.useCase.hasUserLoggedInCalled) == true
                    expect(self.output.hasUserLoggedIn).toEventually(beFalse())
                }
            }
        }
    }
}
