//
//  KeychainToken.swift
//  Survey
//
//  Created by Khanh on 02/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

struct KeychainToken: Token, Codable {

    let id: String
    let type: String
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let createdAt: TimeInterval

    init(token: Token) {
        id = token.id
        type = token.type
        accessToken = token.accessToken
        tokenType = token.tokenType
        expiresIn = token.expiresIn
        refreshToken = token.refreshToken
        createdAt = token.createdAt
    }
}
