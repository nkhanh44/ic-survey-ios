//
//  HomeViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 24/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

//  swiftlint:disable closure_body_length function_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class HomeViewModelSpec: QuickSpec {

    var input: HomeViewModel.Input!
    var output: HomeViewModel.Output!

    override func spec() {
        var viewModel: HomeViewModel!
        var homeUseCase: HomeUseCaseMock!
        var userUseCase: UserUseCaseMock!
        var userSessionUseCase: UserSessionUseCaseMock!
        let loadUserInfoTrigger = PassthroughSubject<Void, Never>()
        let loadTrigger = PassthroughSubject<Void, Never>()
        let willGoToDetail = PassthroughSubject<Void, Never>()
        let logoutTrigger = PassthroughSubject<Void, Never>()
        let reloadTrigger = PassthroughSubject<Void, Never>()

        describe("a HomeViewModel") {

            beforeEach {
                homeUseCase = HomeUseCaseMock()
                userUseCase = UserUseCaseMock()
                userSessionUseCase = UserSessionUseCaseMock()
                viewModel = HomeViewModel(
                    homeUseCase: homeUseCase,
                    userUseCase: userUseCase,
                    userSessionUseCase: userSessionUseCase
                )

                self.input = HomeViewModel.Input(
                    loadUserInfoTrigger: loadUserInfoTrigger.eraseToAnyPublisher(),
                    loadTrigger: loadTrigger.eraseToAnyPublisher(),
                    willGoToDetail: willGoToDetail.eraseToAnyPublisher(),
                    logoutTrigger: logoutTrigger.eraseToAnyPublisher(),
                    reloadTrigger: reloadTrigger.eraseToAnyPublisher()
                )
                self.output = viewModel.transform(self.input)
            }

            context("when load survey list returns success") {

                beforeEach {
                    loadTrigger.send()
                    willGoToDetail.send()
                }

                it("has getSurveyList called") {
                    expect(homeUseCase.getSurveyListCalled) == true
                }

                it("returns output with not empty items") {
                    expect(self.output.surveys).toNotEventually(beEmpty())
                }

                it("moves to detail") {
                    expect(self.output.willGoToDetail).toEventually(beTrue())
                }
            }

            context("when load survey list returns failure with error alert") {

                it("returns output with alert displayed") {
                    homeUseCase.getSurveyListReturnValue = .failure(TestError())

                    loadTrigger.send()

                    expect(self.output.alert).toEventuallyNot(beNil())
                }
            }

            context("when load user info returns success") {

                beforeEach {
                    loadUserInfoTrigger.send()
                }

                it("has getUser called") {
                    expect(userUseCase.getUserCalled) == true
                }

                it("returns output with not nil user") {
                    expect(self.output.user).toNotEventually(beNil())
                }
            }

            context("when load user info returns failure with error alert") {

                it("returns output with alert displayed") {
                    userUseCase.getUserReturnValue = .failure(TestError())

                    loadUserInfoTrigger.send()

                    expect(self.output.alert).toEventuallyNot(beNil())
                }
            }

            context("when user logout returns success") {

                beforeEach {
                    loadUserInfoTrigger.send()
                    logoutTrigger.send()
                }

                it("has logout called") {
                    expect(userUseCase.logoutCalled) == true
                }

                it("returns output with true") {
                    expect(self.output.didLogoutSuccessfully).toEventually(beTrue())
                }
            }

            context("when user logout returns failure with error alert") {

                it("returns output with alert displayed") {
                    userUseCase.logoutReturnValue = .failure(TestError())

                    loadUserInfoTrigger.send()
                    logoutTrigger.send()

                    expect(self.output.alert).toEventuallyNot(beNil())
                }
            }

            context("when reload survey list returns success") {

                beforeEach {
                    reloadTrigger.send()
                }

                it("has getSurveyList called") {
                    expect(homeUseCase.getSurveyListCalled) == true
                }

                it("returns output with not empty items") {
                    expect(self.output.surveys).toNotEventually(beEmpty())
                }
            }

            context("when reload survey list returns failure with error alert") {

                it("returns output with alert displayed") {
                    homeUseCase.getSurveyListReturnValue = .failure(TestError())

                    reloadTrigger.send()

                    expect(self.output.alert).toEventuallyNot(beNil())
                }
            }
        }
    }
}
