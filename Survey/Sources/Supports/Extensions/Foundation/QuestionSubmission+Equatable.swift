//
//  QuestionSubmission+Equatable.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension QuestionSubmission: Equatable {

    static func == (lhs: QuestionSubmission, rhs: QuestionSubmission) -> Bool {
        lhs.id == rhs.id
    }
}
