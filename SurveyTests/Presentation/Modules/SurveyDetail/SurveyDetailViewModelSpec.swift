//
//  SurveyDetailViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 22/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SurveyDetailViewModelSpec: QuickSpec {

    var input: SurveyDetailViewModel.Input!
    var output: SurveyDetailViewModel.Output!

    override func spec() {
        var viewModel: SurveyDetailViewModel!
        let nextToSurveyQuestionTrigger = PassthroughSubject<Void, Never>()

        describe("a SurveyDetailViewModel") {

            beforeEach {
                viewModel = SurveyDetailViewModel()

                self.input = SurveyDetailViewModel.Input(
                    nextToSurveyQuestionTrigger: nextToSurveyQuestionTrigger.asDriver()
                )
                self.output = viewModel.transform(self.input)
            }

            context("when tap next button returns success") {

                it("returns output didNextSuccessfully with true") {
                    nextToSurveyQuestionTrigger.send(())

                    expect(self.output.didNextSuccessfully).toEventually(beTrue())
                }
            }
        }
    }
}
