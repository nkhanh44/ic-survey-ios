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

    var input: SurveyDetailViewModel.Input!
    var output: SurveyDetailViewModel.Output!
    var surveyQuestionUseCase: SurveyQuestionUseCaseMock!

    override func spec() {
        var viewModel: SurveyDetailViewModel!
        let startSurveyTrigger = PassthroughSubject<String, Never>()
        let willShowQuestions = PassthroughSubject<Bool, Never>()
        let dismissAlertTrigger = PassthroughSubject<Void, Never>()

        describe("a SurveyDetailViewModel") {

            beforeEach {
                self.surveyQuestionUseCase = SurveyQuestionUseCaseMock()
                viewModel = SurveyDetailViewModel(
                    surveyQuestionUseCase: self.surveyQuestionUseCase
                )
                self.input = SurveyDetailViewModel.Input(
                    startSurveyTrigger: startSurveyTrigger.asDriver(),
                    willShowQuestions: willShowQuestions.asDriver(),
                    dismissAlert: dismissAlertTrigger.asDriver()
                )
                self.output = viewModel.transform(self.input)
            }

            context("when tap next button") {

                context("returns success") {

                    beforeEach {
                        startSurveyTrigger.send("id")
                        willShowQuestions.send(true)
                    }

                    it("returns output survey not nil") {
                        expect(self.output.$survey).toEventuallyNot(beNil())
                    }

                    it("returns output isSurveyQuestionPresented is true") {
                        expect(self.output.isSurveyQuestionPresented).toEventually(beTrue())
                    }
                }

                context("returns failure") {

                    beforeEach {
                        self.surveyQuestionUseCase.getSurveyDetailReturnValue = .failure(TestError())
                        startSurveyTrigger.send("id")
                    }

                    it("returns output alert not nil") {
                        expect(self.output.alert).toEventuallyNot(beNil())
                    }

                    it("returns output isSurveyQuestionPresented is false") {
                        expect(self.output.isSurveyQuestionPresented) == false
                    }
                }
            }
        }
    }
}
