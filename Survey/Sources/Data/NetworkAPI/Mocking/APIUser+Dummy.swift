//
//  APIUser+Dummy.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension APIUser {

    static let dummy = APIUser(
        id: "1",
        type: "user",
        email: "dev@nimblehq.co",
        name: "Nimble",
        avatarUrl: "https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d"
    )
}
