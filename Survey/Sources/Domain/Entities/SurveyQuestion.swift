//
//  SurveyQuestion.swift
//  Survey
//
//  Created by Khanh on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

//  swiftlint:disable file_types_order

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

    var sortedAnswers: [SurveyAnswer] {
        answers?.sorted { $0.displayOrder < $1.displayOrder } ?? []
    }
}

enum DisplayType: String, Codable {

    case star
    case heart
    case smiley
    case choice
    case dropdown
    case nps
    case textarea
    case textfield
    case intro
    case outro
}

enum PickType: String, Codable {

    case one, any, none
}
