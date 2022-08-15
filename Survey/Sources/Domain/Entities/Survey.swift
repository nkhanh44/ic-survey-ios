//
//  Survey.swift
//  SurveyTests
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
}
