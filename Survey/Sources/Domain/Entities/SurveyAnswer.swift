//
//  SurveyAnswer.swift
//  Survey
//
//  Created by Khanh on 14/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

protocol SurveyAnswer {

    var id: String { get }
    var displayOrder: Int { get }
    var text: String? { get }
    var inputMaskPlaceholder: String? { get }
}
