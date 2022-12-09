//
//  QuestionSubmissionStorage.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//
// swiftlint:disable let_var_whitespace

protocol QuestionSubmissionCachable {

    var questionsSubmission: [QuestionSubmission] { get set }
}

struct QuestionSubmissionStorage: QuestionSubmissionCachable {

    static let shared = QuestionSubmissionStorage()

    @Storage(key: Constants.UserDefaultKeys.questionsSubmission, defaultValue: [])
    var questionsSubmission: [QuestionSubmission]
}
