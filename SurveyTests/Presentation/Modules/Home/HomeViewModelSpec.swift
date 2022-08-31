//
//  HomeViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 24/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

//  swiftlint:disable closure_body_length

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
        var useCase: HomeUseCaseMock!
        let loadTrigger = PassthroughSubject<Void, Never>()
        let willGoToDetail = PassthroughSubject<Void, Never>()

        describe("a HomeViewModel") {

            beforeEach {
                useCase = HomeUseCaseMock()
                viewModel = HomeViewModel(useCase: useCase)

                self.input = HomeViewModel.Input(
                    loadTrigger: loadTrigger.eraseToAnyPublisher(),
                    willGoToDetail: willGoToDetail.eraseToAnyPublisher()
                )
                self.output = viewModel.transform(self.input)
            }

            context("when load survey list returns success") {

                beforeEach {
                    loadTrigger.send()
                    willGoToDetail.send()
                }

                it("has getSurveyListCalled called") {
                    expect(useCase.getSurveyListCalled) == true
                }

                it("returns output with not empty items and move to detail") {
                    expect(self.output.surveys).toNotEventually(beEmpty())
                }

                it("moves to detail") {
                    expect(self.output.willGoToDetail).toEventually(beTrue())
                }
            }

            context("when load survey list returns failure with error alert") {

                it("returns output with alert displayed") {
                    useCase.getSurveyListReturnValue = .failure(TestError())

                    loadTrigger.send()

                    expect(self.output.alert).toEventuallyNot(beNil())
                }
            }
        }
    }
}
