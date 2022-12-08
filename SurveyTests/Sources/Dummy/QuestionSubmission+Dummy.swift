//
//  QuestionSubmission+Dummy.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

extension QuestionSubmission {

    static var dummy = [
        QuestionSubmission(
            id: "1",
            answers: AnswerSubmission.dummy
        ),
        QuestionSubmission(
            id: "2",
            answers: AnswerSubmission.dummy
        )
    ]
}
