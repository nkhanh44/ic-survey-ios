//
//  AnswerSubmission+Dummy.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

extension AnswerSubmission {

    static var dummy = [
        AnswerSubmission(id: "01", answer: "name"),
        AnswerSubmission(id: "02", answer: "age"),
        AnswerSubmission(id: "03", answer: "address")
    ]
}
