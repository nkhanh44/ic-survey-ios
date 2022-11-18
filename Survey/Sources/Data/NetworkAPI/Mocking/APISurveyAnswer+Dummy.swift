//
//  APISurveyAnswer+Dummy.swift
//  Survey
//
//  Created by Khanh on 18/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension APISurveyAnswer {

    static var dummy = [
        APISurveyAnswer(
            id: "1",
            type: "answer",
            displayOrder: 1,
            text: "choice 1",
            inputMaskPlaceholder: nil
        ),
        APISurveyAnswer(
            id: "2",
            type: "answer",
            displayOrder: 2,
            text: "choice 2",
            inputMaskPlaceholder: nil
        )
    ]
}
