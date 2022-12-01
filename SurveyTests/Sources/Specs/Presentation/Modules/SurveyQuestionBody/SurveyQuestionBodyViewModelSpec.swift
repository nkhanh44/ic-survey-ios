//
//  SurveyQuestionBodyViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 23/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SurveyQuestionBodyViewModelSpec: QuickSpec {

    override func spec() {
        var input: SurveyQuestionBodyViewModel.Input!
        var output: SurveyQuestionBodyViewModel.Output!
        var viewModel: SurveyQuestionBodyViewModel!
        let loadTrigger = PassthroughSubject<Void, Never>()

        describe("a SurveyQuestionBodyViewModel") {

            beforeEach {
                viewModel = SurveyQuestionBodyViewModel(
                    question: APISurveyQuestion.dummy[0],
                    numberOfQuestions: 2
                )

                input = SurveyQuestionBodyViewModel.Input(
                    loadTrigger: loadTrigger.eraseToAnyPublisher()
                )
                output = viewModel.transform(input)
            }

            context("when loadingTrigger is called") {

                let expectedSurveyQuestion = APISurveyQuestion.dummy[0]

                beforeEach {
                    loadTrigger.send(())
                }

                it("returns output question") {
                    expect(output.question?.id) == expectedSurveyQuestion.id
                }
            }
        }
    }
}
