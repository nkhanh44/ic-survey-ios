//
//  SurveyQuestion.swift
//  Survey
//
//  Created by Khanh on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol SurveyQuestion {

    var id: String { get }
    var displayOrder: Int { get }
    var displayType: DisplayType { get }
    var text: String { get }
    var pick: PickType { get }
    var coverImageUrl: String { get }
    var answers: [SurveyAnswer]? { get }
}

extension SurveyQuestion {

    var largeImageURL: URL? {
        URL(string: coverImageUrl + "l")
    }
}
