//
//  Data+.swift
//  Survey
//
//  Created by Khanh on 04/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Data {

    var errorData: SError {
        if let errorResponseArray = try? JSONDecoder().decode(
            ErrorResponseArray.self,
            from: self
        ), let errorResponse = errorResponseArray.errors.first {
            return SError.api(errorResponse)
        }
        return SError.empty
    }
}
