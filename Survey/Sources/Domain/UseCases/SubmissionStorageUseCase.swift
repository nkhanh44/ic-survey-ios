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

    let repository: QuestionSubmissionRepositoryProtocol

    func store(data: [QuestionSubmission]) {
        repository.save(data: data)
    }

    func load() -> [QuestionSubmission] {
        repository.getData()
    }

    func delete() -> Observable<Bool> {
        repository.removeData()
    }
}
