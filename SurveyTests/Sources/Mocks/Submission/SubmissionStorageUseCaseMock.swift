//
//  SubmissionStorageUseCaseMock.swift
//  SurveyTests
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

@testable import Survey

final class SubmissionStorageUseCaseMock: SubmissionStorageUseCaseProtocol {

    var storeCalled = false
    var loadCalled = false
    var loadReturnValue = QuestionSubmission.dummy
    var deleteCalled = false
    var deleteReturnValue = Observable.just(true)
    var dataArgument: [QuestionSubmission]?

    func store(data: [QuestionSubmission]) {
        dataArgument = data
        storeCalled = true
    }

    func load() -> [QuestionSubmission] {
        loadCalled = true
        return loadReturnValue
    }

    func delete() -> Observable<Bool> {
        deleteCalled = true
        return deleteReturnValue.asObservable()
    }
}
