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

        describe("a SurveyDetailView") {

            beforeEach {
                guard let survey = APISurvey.dummyList.first else { return }
                surveyDetailView = SurveyDetailView(
                    viewModel: SurveyDetailViewModel(),
                    isPresented: .constant(true),
                    survey: survey
                )
            }

            context("has onAppear called") {

                it("did not call next") {
                    expect(surveyDetailView.output.didNextSuccessfully) == false
                }
            }
        }
    }
}
