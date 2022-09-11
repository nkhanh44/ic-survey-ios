//
//  APIUser.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Japx

struct APIUser: User, JapxCodable {

    let id: String
    let type: String
    let email: String
    let name: String
    let avatarUrl: String
}

extension APIUser {

    enum CodingKeys: String, CodingKey {

        case id, type, email, name
        case avatarUrl = "avatar_url"
    }
}
