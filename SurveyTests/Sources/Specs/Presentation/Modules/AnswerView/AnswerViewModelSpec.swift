//
//  AnswerViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 23/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

//  swiftlint:disable function_body_length closure_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class AnswerViewModelSpec: QuickSpec {

    override func spec() {
        var submissionStorageUseCase: SubmissionStorageUseCaseMock!
        var input: AnswerViewModel.Input!
        var output: AnswerViewModel.Output!
        var viewModel: AnswerViewModel!
        let npsRatingTrigger = PassthroughSubject<Int, Never>()
        let selectedAnswers = PassthroughSubject<SelectedAnswer?, Never>()

        describe("an AnswerViewModel") {

            let id = "1"
            let displayType: DisplayType = .choice
            let pickType: PickType = .any

            beforeEach {
                submissionStorageUseCase = SubmissionStorageUseCaseMock()
                viewModel = AnswerViewModel(
                    surveyAnswers: APISurveyAnswer.dummy,
                    displayType: displayType,
                    pickType: pickType,
                    idQuestion: id,
                    submissionStorageUseCase: submissionStorageUseCase
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

            context("when selectedAnswers called and complete answer") {

                let selectedAnswer = SelectedAnswer(index: 1, text: "name")

                beforeEach {
                    submissionStorageUseCase.loadReturnValue = QuestionSubmission.dummy
                    selectedAnswers.send(selectedAnswer)
                }

                it("submissionStorageUseCase calls load") {
                    expect(submissionStorageUseCase.loadCalled) == true
                }

                it("submissionStorageUseCase calls store") {
                    expect(submissionStorageUseCase.storeCalled) == true
                }

                it("returns output didAnswer with Void") {
                    expect(output.didAnswer) == ()
                }
            }
        }
    }
}
