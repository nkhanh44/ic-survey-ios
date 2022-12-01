//
//  SubmitSurveyUseCaseSpec.swift
//  Survey
//
//  Created by Khanh on 27/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
@testable import Survey

final class SubmitSurveyUseCaseSpec: QuickSpec {

    override func spec() {
        var submitSurveyUseCase: SubmitSurveyUseCase!
        var surveyRepository: SurveyRepositoryMock!

        describe("a SubmitSurveyUseCase") {

            beforeEach {
                surveyRepository = SurveyRepositoryMock()
                submitSurveyUseCase = SubmitSurveyUseCase(surveyRepository: surveyRepository)
            }

            context("when submit is called") {

                let id = "d5de6a8f8f5f1cfe51bc"
                let questionSubmissions = [
                    QuestionSubmission(
                        id: "d3afbcf2b1d60af845dc",
                        answers: [
                            AnswerSubmission(id: "f09f1a680789b636459b")
                        ]
                    )
                ]

                beforeEach {
                    _ = submitSurveyUseCase.submit(
                        id: id,
                        questionSubmissions: questionSubmissions
                    )
                }

                it("surveyRepository calls submit") {
                    expect(surveyRepository.submitCalled) == true
                }

                it("surveyRepository calls submit with correct id") {
                    expect(surveyRepository.submitIdArgument) == id
                }

                it("surveyRepository calls submit with correct questionSubmissions") {
                    expect(surveyRepository.submitQuestionSubmissionsArgument?.count) == questionSubmissions.count
                }
            }
        }
    }
}
