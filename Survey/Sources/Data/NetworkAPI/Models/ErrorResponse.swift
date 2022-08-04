//
//  ErrorResponse.swift
//  Survey
//
//  Created by Khanh on 04/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct ErrorResponseArray: Codable {

    let errors: [ErrorResponse]
}

struct ErrorResponse: Codable {

    let detail: String
    let code: String
}
