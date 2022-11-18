//
//  SurveyQuestionUseCaseMock.swift
//  Survey
//
//  Created by Khanh on 18/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

import Combine

final class SurveyQuestionUseCaseMock: SurveyQuestionUseCaseProtocol {

    var getSurveyDetailCalled = false
    var getSurveyDetailReturnValue = Result<Survey, Error>.success(APISurvey.dummyList.first!)

    func getSurveyDetail(id: String) -> Observable<Survey> {
        getSurveyDetailCalled = true
        return getSurveyDetailReturnValue.publisher.eraseToAnyPublisher()
    }
}
