//
//  APISurveyQuestion.swift
//  SurveyTests
//
//  Created by Khanh on 21/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

extension APISurveyQuestion {

    static var dummy = [
        APISurveyQuestion(
            id: "123",
            type: "question",
            displayOrder: 2,
            displayType: .choice,
            text: "What was the primary reason for selecting ibis Bangkok Riverside?",
            pick: .one,
            coverImageUrl: "https://dhdbhh0jsld0o.cloudfront.net/m/6c2f22966125fd0a7170_",
            apiAnswers: APISurveyAnswer.dummy
        ),
        APISurveyQuestion(
            id: "456",
            type: "question",
            displayOrder: 2,
            displayType: .outro,
            text: "Thank you for taking the time to complete the survey",
            pick: .one,
            coverImageUrl: "https://dhdbhh0jsld0o.cloudfront.net/m/6c2f22966125fd0a7170_",
            apiAnswers: APISurveyAnswer.dummy
        )
    ]
}
