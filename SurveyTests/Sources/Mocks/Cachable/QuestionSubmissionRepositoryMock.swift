//
//  QuestionSubmissionRepositoryMock.swift
//  SurveyTests
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
@testable import Survey

final class QuestionSubmissionRepositoryMock: QuestionSubmissionRepositoryProtocol {

    var getDataCalled = false

    var getDataReturnValue = QuestionSubmission.dummy

    var saveCalled = false

    var removeDataCalled = false

    var removeDataReturnValue = Observable.just(true)

    var dataArgument: [QuestionSubmission]?

    func getData() -> [QuestionSubmission] {
        getDataCalled = true
        return getDataReturnValue
    }

    func save(data: [QuestionSubmission]) {
        saveCalled = true
        dataArgument = data
    }

    func removeData() -> Observable<Bool> {
        removeDataCalled = true
        return removeDataReturnValue.asObservable()
    }
}
