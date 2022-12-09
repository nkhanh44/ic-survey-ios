//
//  SubmitSurveyUseCaseMock.swift
//  SurveyTests
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

@testable import Survey

final class SubmitSurveyUseCaseMock: SubmitSurveyUseCaseProtocol {

    var submitCalled = false
    var submitReturnValue = Result<Bool, Error>.success(true)
    var idArgument: String?
    var questionSubmissionsArgument: [QuestionSubmission]?

    func submit(
        id: String,
        questionSubmissions: [QuestionSubmission]
    ) -> Observable<Bool> {
        idArgument = id
        questionSubmissionsArgument = questionSubmissions
        submitCalled = true
        return submitReturnValue.publisher.eraseToAnyPublisher()
    }
}
