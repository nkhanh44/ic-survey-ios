//
//  Survey.swift
//
//  Created by Khanh on 10/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol Survey {

    var id: String { get }
    var title: String { get }
    var description: String { get }
    var coverImageURL: String { get }
    var questions: [SurveyQuestion]? { get }
}

extension Survey {

    var largeImageURL: URL? {
        URL(string: coverImageURL + "l")
    }

    var sortedQuestions: [SurveyQuestion]? {
        questions?.sorted { $0.displayOrder < $1.displayOrder }
    }
}
