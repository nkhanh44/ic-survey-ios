//
//  SurveyRepositoryMock.swift
//  SurveyTests
//
//  Created by Khanh on 24/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
@testable import Survey

final class SurveyRepositoryMock: SurveyRepositoryProtocol {

    var getSurveyDetailCalled = false

    var getSurveyDetailReturnValue = Observable.just(APISurvey.dummyList[0])

    var getSurveyListCalled = false

    var getSurveyListReturnValue = Observable.just(APISurvey.dummyList)

    var submitCalled = false

    var submitReturnValue = Observable.just(true)

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Observable<[Survey]> {
        getSurveyListCalled = true
        return getSurveyListReturnValue.map { $0 as [Survey] }.asObservable()
    }

    func getSurveyDetail(id: String) -> Observable<Survey> {
        getSurveyDetailCalled = true
        return getSurveyDetailReturnValue.map { $0 as Survey }.asObservable()
    }

    func submit(id: String, questionSubmissions: [QuestionSubmission]) -> Observable<Bool> {
        submitCalled = true
        return submitReturnValue.asObservable()
    }
}
