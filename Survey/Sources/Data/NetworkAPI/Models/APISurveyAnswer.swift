//
//  APISurveyAnswer.swift
//  Survey
//
//  Created by Khanh on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import Japx

struct APISurveyAnswer: SurveyAnswer, JapxCodable {

    let id: String
    var type: String
    let displayOrder: Int
    let text: String?
    let inputMaskPlaceholder: String?
}

extension APISurveyAnswer {

    enum CodingKeys: String, CodingKey {

        case id, text, type
        case displayOrder = "display_order"
        case inputMaskPlaceholder = "input_mask_placeholder"
    }
}
