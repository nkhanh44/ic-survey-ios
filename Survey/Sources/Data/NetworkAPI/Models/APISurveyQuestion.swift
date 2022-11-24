//
//  APISurveyQuestion.swift
//  Survey
//
//  Created by Khanh on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

struct APISurveyQuestion: SurveyQuestion, Codable {

    let id: String
    var type: String
    let displayOrder: Int
    let displayType: DisplayType
    let text: String
    let pick: PickType
    let coverImageUrl: String
    let apiAnswers: [APISurveyAnswer]?

    var answers: [SurveyAnswer]? { apiAnswers }
}

extension APISurveyQuestion {

    enum CodingKeys: String, CodingKey {

        case id, text, pick, type
        case displayOrder = "display_order"
        case displayType = "display_type"
        case coverImageUrl = "cover_image_url"
        case apiAnswers = "answers"
    }
}
