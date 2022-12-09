//
//  QuestionSubmissionRepository.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol QuestionSubmissionRepositoryProtocol: AnyObject {

    func getData() -> [QuestionSubmission]
    func save(data: [QuestionSubmission])
    func removeData() -> Observable<Bool>
}

final class QuestionSubmissionRepository: QuestionSubmissionRepositoryProtocol {

    private var storage: QuestionSubmissionCachable!

    required init(storage: QuestionSubmissionCachable) {
        self.storage = storage
    }

    func getData() -> [QuestionSubmission] {
        storage.questionsSubmission
    }

    func save(data: [QuestionSubmission]) {
        storage.questionsSubmission = data
    }

    func removeData() -> Observable<Bool> {
        storage.questionsSubmission = []
        return Just(storage.questionsSubmission.isEmpty).asObservable()
    }
}
