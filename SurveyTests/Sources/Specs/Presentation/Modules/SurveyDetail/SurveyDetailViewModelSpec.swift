//
//  SurveyDetailViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 22/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

//  swiftlint:disable closure_body_length

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SurveyDetailViewModelSpec: QuickSpec {

    override func spec() {
        var input: SurveyDetailViewModel.Input!
        var output: SurveyDetailViewModel.Output!
        var surveyQuestionUseCase: SurveyQuestionUseCaseMock!
        var viewModel: SurveyDetailViewModel!
        let startSurveyTrigger = PassthroughSubject<String, Never>()
        let willShowQuestions = PassthroughSubject<Bool, Never>()
        let dismissAlertTrigger = PassthroughSubject<Void, Never>()

        describe("a SurveyDetailViewModel") {

            beforeEach {
                surveyQuestionUseCase = SurveyQuestionUseCaseMock()
                viewModel = SurveyDetailViewModel(
                    surveyQuestionUseCase: surveyQuestionUseCase
                )
                input = SurveyDetailViewModel.Input(
                    startSurveyTrigger: startSurveyTrigger.asDriver(),
                    willShowQuestions: willShowQuestions.asDriver(),
                    dismissAlert: dismissAlertTrigger.asDriver()
                )
                output = viewModel.transform(input)
            }

            context("when tap next button") {

                context("returns success") {

                    beforeEach {
                        startSurveyTrigger.send("id")
                        willShowQuestions.send(true)
                    }

                    it("returns output survey not nil") {
                        expect(output.$survey).toEventuallyNot(beNil())
                    }

                    it("returns output isSurveyQuestionPresented is true") {
                        expect(output.isSurveyQuestionPresented).toEventually(beTrue())
                    }
                }

                context("returns failure") {

                    beforeEach {
                        surveyQuestionUseCase.getSurveyDetailReturnValue = .failure(TestError())
                        startSurveyTrigger.send("id")
                    }

                    it("returns output isSurveyQuestionPresented is false") {
                        expect(output.isSurveyQuestionPresented) == false
                    }
                }
            }
        }
    }
}
