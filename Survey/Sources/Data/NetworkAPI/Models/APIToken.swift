//
//  APIToken.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import Japx

struct APIToken: Token, JapxCodable {

    let id: String
    let type: String
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let createdAt: TimeInterval
}

extension APIToken {

    enum CodingKeys: String, CodingKey {

        case id, type
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
}
