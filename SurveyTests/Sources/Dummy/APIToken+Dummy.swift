//
//  APIToken+Dummy.swift
//  SurveyTests
//
//  Created by Khanh on 08/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

extension APIToken {

    static let dummy = APIToken(
        id: "1",
        type: "token",
        accessToken: "accessToken",
        tokenType: "tokenType",
        expiresIn: 900,
        refreshToken: "refreshToken",
        createdAt: 1_888_882
    )
}
