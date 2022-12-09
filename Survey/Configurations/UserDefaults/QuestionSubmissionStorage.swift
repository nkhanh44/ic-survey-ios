//
//  QuestionSubmissionStorage.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

protocol QuestionSubmissionCachable {

    var questionsSubmission: [QuestionSubmission] { get set }
}

final class QuestionSubmissionStorage: QuestionSubmissionCachable {

    static let shared = QuestionSubmissionStorage()
    var questionsSubmission: [QuestionSubmission] = []
}
