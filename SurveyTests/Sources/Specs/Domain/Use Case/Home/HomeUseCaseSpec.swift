//
//  HomeUseCaseSpec.swift
//  Survey
//
//  Created by Khanh on 24/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
@testable import Survey

final class HomeUseCaseSpec: QuickSpec {

    override func spec() {
        var useCase: HomeUseCase!
        var repository: SurveyRepositoryMock!

        describe("a HomeUseCase") {

            beforeEach {
                repository = SurveyRepositoryMock()
                useCase = HomeUseCase(
                    surveyRepository: repository
                )
            }

            context("when getSurveyListCalled is called") {

                beforeEach {
                    _ = useCase.getSurveyList(pageNumber: 1, pageSize: 10)
                }

                it("returns correct response") {
                    expect(repository.getSurveyListCalled) == true
                }
            }
        }
    }
}
