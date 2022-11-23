//
//  APISurveyAnswer+Dummy.swift
//  Survey
//
//  Created by Khanh on 23/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

extension APISurveyAnswer {

    static var dummy = [
        APISurveyAnswer(
            id: "1",
            type: "answer",
            displayOrder: 1,
            text: "choice 1",
            inputMaskPlaceholder: "placeholder"
        ),
        APISurveyAnswer(
            id: "2",
            type: "answer",
            displayOrder: 2,
            text: "choice 2",
            inputMaskPlaceholder: "placeholder"
        )
    ]
}
