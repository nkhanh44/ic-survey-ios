//
//  APISurvey.swift
//  Survey
//
//  Created by Khanh on 10/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import Japx

struct APISurvey: Survey, JapxCodable {

    let id: String
    let type: String
    let title: String
    let description: String
    var coverImageURL: String
}

extension APISurvey {

    enum CodingKeys: String, CodingKey {

        case id, type, title, description
        case coverImageURL = "cover_image_url"
    }
}
