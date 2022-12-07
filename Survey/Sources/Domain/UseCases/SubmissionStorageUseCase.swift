//
//  SubmissionStorageUseCase.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol SubmissionStorageUseCaseProtocol {

    func store(data: [QuestionSubmission])
    func load() -> [QuestionSubmission]
    func delete() -> Observable<Bool>
}

final class SubmissionStorageUseCase: SubmissionStorageUseCaseProtocol {

    var storage: QuestionSubmissionCachable

    init(storage: QuestionSubmissionCachable = QuestionSubmissionStorage()) {
        self.storage = storage
    }

    func store(data: [QuestionSubmission]) {
        storage.questionsSubmission = data
    }

    func load() -> [QuestionSubmission] {
        storage.questionsSubmission
    }

    func delete() -> Observable<Bool> {
        storage.questionsSubmission = []
        return Just(storage.questionsSubmission.isEmpty).asObservable()
    }
}
