//
//  SurveyQuestionViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
//  swiftlint:disable function_body_length closure_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SurveyQuestionViewModelSpec: QuickSpec {

    override func spec() {
        var submitSurveyUseCase: SubmitSurveyUseCaseMock!
        var submissionStorageUseCase: SubmissionStorageUseCaseMock!
        var input: SurveyQuestionViewModel.Input!
        var output: SurveyQuestionViewModel.Output!
        var viewModel: SurveyQuestionViewModel!
        let submitTrigger = PassthroughSubject<Void, Never>()
        let dismissAlert = PassthroughSubject<Void, Never>()
        let clearSubmissionTrigger = PassthroughSubject<Void, Never>()
        let onAppearTrigger = PassthroughSubject<[SurveyQuestion], Never>()

        describe("A SurveyQuestionViewModel") {

            let id = "d5de6a8f8f5f1cfe51bc"

            beforeEach {
                submitSurveyUseCase = SubmitSurveyUseCaseMock()
                submissionStorageUseCase = SubmissionStorageUseCaseMock()
                viewModel = SurveyQuestionViewModel(
                    submitSurveyUseCase: submitSurveyUseCase,
                    submissionStorageUseCase: submissionStorageUseCase,
                    id: id
                )

                input = SurveyQuestionViewModel.Input(
                    submitTrigger: submitTrigger.eraseToAnyPublisher(),
                    dismissAlert: dismissAlert.eraseToAnyPublisher(),
                    clearSubmissionTrigger: clearSubmissionTrigger.eraseToAnyPublisher(),
                    onAppearTrigger: onAppearTrigger.eraseToAnyPublisher()
                )
                output = viewModel.transform(input)
            }

            describe("its onAppearTrigger called") {

                beforeEach {
                    onAppearTrigger.send(APISurveyQuestion.dummy)
                }

                context("when submissionStorageUseCase calls store") {

                    it("returns output done") {
                        expect(output.done) == ()
                    }
                }

                context("when submissionStorageUseCase calls delete") {

                    it("submissionStorageUseCase calls delete") {
                        expect(submissionStorageUseCase.deleteCalled) == true
                    }

                    it("delete returns correct response") {
                        let response = submissionStorageUseCase.delete()
                        let result = try self.awaitPublisher(response)
                        expect(result) == true
                    }
                }
            }

            describe("its clearSubmissionTrigger called") {

                beforeEach {
                    clearSubmissionTrigger.send()
                }

                context("when submissionStorageUseCase calls delete") {

                    it("returns output done") {
                        expect(output.done) == ()
                    }

                    it("delete returns a correct response") {
                        let response = submissionStorageUseCase.delete()
                        let result = try self.awaitPublisher(response)
                        expect(result) == true
                    }
                }
            }

            context("when submitting answers returns success") {

                beforeEach {
                    submitTrigger.send()
                }

                it("submissionStorageUseCase calls load") {
                    expect(submissionStorageUseCase.loadCalled) == true
                }

                it("submitSurveyUseCase calls submit") {
                    expect(submitSurveyUseCase.submitCalled) == true
                }

                it("submitSurveyUseCase calls submit with correct id argument") {
                    expect(submitSurveyUseCase.idArgument) == id
                }

                it("submitSurveyUseCase calls submit with correct questionSubmissions argument") {
                    expect(submitSurveyUseCase.questionSubmissionsArgument) == submissionStorageUseCase.loadReturnValue
                }

                it("returns output isSuccess with a correct response") {
                    expect(output.isSuccess).toEventually(beTrue())
                }
            }

            context("when submitting answers returns failure with error alert") {

                beforeEach {
                    submitSurveyUseCase.submitReturnValue = .failure(TestError())
                    submitTrigger.send()
                }

                it("submissionStorageUseCase calls load") {
                    expect(submissionStorageUseCase.loadCalled) == true
                }

                it("submitSurveyUseCase calls submit") {
                    expect(submitSurveyUseCase.submitCalled) == true
                }

                it("submitSurveyUseCase calls submit with correct id argument") {
                    expect(submitSurveyUseCase.idArgument) == id
                }

                it("submitSurveyUseCase calls submit with correct questionSubmissions argument") {
                    expect(submitSurveyUseCase.questionSubmissionsArgument) == submissionStorageUseCase.loadReturnValue
                }

                it("returns output isSuccess with a correct response") {
                    expect(output.isSuccess).toEventually(beFalse())
                }

                it("returns output alert not nil") {
                    expect(output.alert).toNotEventually(beNil())
                }
            }

            context("when submitting no answer returns nothing") {

                let expectedData = [QuestionSubmission]()

                beforeEach {
                    submissionStorageUseCase.loadReturnValue = []
                    submitTrigger.send()
                }

                it("submissionStorageUseCase calls load") {
                    expect(submissionStorageUseCase.loadCalled) == true
                }

                it("submissionStorageUseCase return empty answer") {
                    expect(submissionStorageUseCase.loadReturnValue) == expectedData
                }

                it("submitSurveyUseCase does not call submit") {
                    expect(submitSurveyUseCase.submitCalled) == false
                }
            }
        }
    }
}
