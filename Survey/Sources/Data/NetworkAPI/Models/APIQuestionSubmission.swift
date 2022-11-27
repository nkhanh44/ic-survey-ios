//
//  APIQuestionSubmission.swift
//  Survey
//
//  Created by Khanh on 24/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct APIQuestionSubmission: Codable {

    let id: String
    let answers: [APIAnswerSubmission]

    init(questionSubmission: QuestionSubmission) {
        id = questionSubmission.id
        answers = questionSubmission.answers.map(APIAnswerSubmission.init)
    }
}

extension APIQuestionSubmission {

    var asParameters: [String: Any]? {
        let encoder = JSONEncoder()
        return (try? JSONSerialization.jsonObject(with: encoder.encode(self))) as? [String: Any]
    }
}
