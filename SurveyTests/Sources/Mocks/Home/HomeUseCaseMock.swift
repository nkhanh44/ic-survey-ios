//
//  HomeUseCaseMock.swift
//  Survey
//
//  Created by Khanh on 24/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
@testable import Survey

final class HomeUseCaseMock: HomeUseCaseProtocol {

    var getSurveyListCalled = false

    var getSurveyListReturnValue = Result<[Survey], Error>.success(APISurvey.dummyList)

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Observable<[Survey]> {
        getSurveyListCalled = true
        return getSurveyListReturnValue.publisher.eraseToAnyPublisher()
    }
}
