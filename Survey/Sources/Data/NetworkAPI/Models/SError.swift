//
//  SError.swift
//  Survey
//
//  Created by Khanh on 02/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

enum SError: Error, Equatable {

    // Validate Error
    case invalidEmail
    case invalidPassword

    // API Error
    case api(ErrorResponse)
    case empty

    // get detail
    var detail: String {
        switch self {
        case let .api(errorResponse):
            return errorResponse.detail
        case .empty:
            return ""
        case .invalidEmail:
            return "Whoops, it seems the email is incorrect. Please check and try again."
        case .invalidPassword:
            return "The password must be at least 8 letters"
        }
    }

    static func == (lhs: SError, rhs: SError) -> Bool {
        lhs.detail == rhs.detail
    }
}
