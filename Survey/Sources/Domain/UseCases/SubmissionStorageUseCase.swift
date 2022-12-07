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

struct SubmissionStorageUseCase: SubmissionStorageUseCaseProtocol {

    let storage: UserStorageProtocol

    init(storage: UserStorageProtocol = QuestionSubmissionStorage.shared) {
        self.storage = storage
    }

    func store(data: [QuestionSubmission]) {
        storage.set(objects: data)
    }

    func load() -> [QuestionSubmission] {
        guard let data = storage.get() as? [QuestionSubmission] else {
            return []
        }
        return data
    }

    func delete() -> Observable<Bool> {
        storage.remove()
        guard let data = storage.get() as? [QuestionSubmission] else {
            return Just(false).asObservable()
        }
        return Just(data.isEmpty).asObservable()
    }
}
