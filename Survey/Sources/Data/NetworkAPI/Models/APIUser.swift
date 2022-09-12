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
