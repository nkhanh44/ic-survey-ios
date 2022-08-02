//
//  LogInRequestConfiguration.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire

enum LogInRequestConfiguration {

    static func login(email: String, password: String) -> RequestConfiguration {
        RequestConfiguration(
            endpoint: "oauth/token",
            method: .post,
            encoding: URLEncoding.default,
            parameters: [
                "grant_type": "password",
                "email": email,
                "password": password,
                "client_id": Constants.Keys.clientId,
                "client_secret": Constants.Keys.clientSecret
            ]
        )
    }
}
