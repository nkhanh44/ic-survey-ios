//
//  APIAnswerSubmission.swift
//  Survey
//
//  Created by Khanh on 24/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct APIAnswerSubmission: Codable {

    let id: String
    let answer: String?

    init(answerSubmission: AnswerSubmission) {
        id = answerSubmission.id
        answer = answerSubmission.answer
    }
}
