//
//  QuestionSubmissionStorage.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

final class QuestionSubmissionStorage: StorageProtocol {

    static let shared = QuestionSubmissionStorage(key: Constants.UserDefaultKeys.questionsSubmission)

    private var storage: Storage<[QuestionSubmission]>

    init(
        key: String,
        defaultValue: [QuestionSubmission] = []
    ) {
        storage = Storage(
            key: key,
            defaultValue: defaultValue
        )
    }

    func get() -> [Any] {
        storage.wrappedValue
    }

    func getValue() -> [QuestionSubmission] {
        get() as? [QuestionSubmission] ?? []
    }

    func set(objects: [Any]) {
        storage.wrappedValue = objects as? [QuestionSubmission] ?? []
    }

    func remove() {
        storage.wrappedValue = []
    }
}
