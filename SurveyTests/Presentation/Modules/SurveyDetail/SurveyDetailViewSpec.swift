//
//  SurveyDetailViewSpec.swift
//  Survey
//
//  Created by Khanh on 22/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick

@testable import Survey

final class SurveyDetailViewSpec: QuickSpec {

    override func spec() {
        var surveyDetailView: SurveyDetailView!
        var surveyQuestionUseCase: SurveyQuestionUseCaseMock!

        describe("a SurveyDetailView") {

            beforeEach {
                guard let survey = APISurvey.dummyList.first else { return }
                surveyQuestionUseCase = SurveyQuestionUseCaseMock()
                surveyDetailView = SurveyDetailView(
                    viewModel: SurveyDetailViewModel(surveyQuestionUseCase: surveyQuestionUseCase),
                    isPresented: .constant(true),
                    survey: survey
                )
            }

            context("has onAppear called") {

                it("alert is not showing") {
                    expect(surveyDetailView.output.$alert).toNot(beNil())
                }
            }
        }
    }
}
