//
//  UserRequestConfiguration.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire

enum UserRequestConfiguration {

    static func getUser() -> RequestConfiguration {
        RequestConfiguration(
            endpoint: "me",
            method: .get,
            encoding: URLEncoding.default
        )
    }

    static func logout() -> RequestConfiguration {
        RequestConfiguration(
            endpoint: "oauth/revoke",
            method: .post,
            encoding: URLEncoding.default,
            parameters: [
                "token": (try? KeychainService.shared.get(key: .token)?.accessToken) ?? "",
                "client_id": Constants.Keys.clientId,
                "client_secret": Constants.Keys.clientSecret
            ]
        )
    }
}
