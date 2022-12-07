//
//  AnswerViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 23/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

//  swiftlint:disable closure_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class AnswerViewModelSpec: QuickSpec {

    override func spec() {
        var input: AnswerViewModel.Input!
        var output: AnswerViewModel.Output!
        var viewModel: AnswerViewModel!
        let npsRatingTrigger = PassthroughSubject<Int, Never>()
        let selectedAnswers = PassthroughSubject<SelectedAnswer?, Never>()

        describe("an AnswerViewModel") {

            beforeEach {
                // TODO: - Remove placeholder in Integrate Part 2
                viewModel = AnswerViewModel(
                    surveyAnswers: APISurveyAnswer.dummy,
                    displayType: .choice,
                    pickType: .any,
                    idQuestion: "id",
                    // TODO: Add SubmissionStorageUseCaseMock in part 2
                    submissionStorageUseCase: SubmissionStorageUseCase()
                )

                input = AnswerViewModel.Input(
                    npsRatingTrigger: npsRatingTrigger.eraseToAnyPublisher(),
                    selectedAnswers: selectedAnswers.eraseToAnyPublisher()
                )
                output = viewModel.transform(input)
            }

            context("when surveyAnswers are not nil") {

                let expectedSurveyAnswer = APISurveyAnswer.dummy

                it("returns output answerTitles with true") {
                    expect(output.answerTitles) == expectedSurveyAnswer.map { $0.text ?? "" }
                }

                it("returns output answerTitles with true") {
                    expect(output.answerPlaceholders) == expectedSurveyAnswer.map { $0.inputMaskPlaceholder ?? "" }
                }

                context("npsRatingTrigger is not nil and select index 2") {

                    beforeEach {
                        npsRatingTrigger.send(2)
                    }

                    it("returns output notLikelyLabelOpacity to 1.0") {
                        expect(output.notLikelyLabelOpacity) == 1.0
                    }

                    it("returns output likelyLabelOpacity to 0.5") {
                        expect(output.likelyLabelOpacity) == 0.5
                    }
                }

                context("npsRatingTrigger is not nil and select index 7") {

                    beforeEach {
                        npsRatingTrigger.send(7)
                    }

                    it("returns output notLikelyLabelOpacity to 0.5") {
                        expect(output.notLikelyLabelOpacity) == 0.5
                    }

                    it("returns output likelyLabelOpacity to 1.0") {
                        expect(output.likelyLabelOpacity) == 1.0
                    }
                }
            }
        }
    }
}
