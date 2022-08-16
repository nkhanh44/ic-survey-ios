//  swiftlint:disable:this file_name
//  Constants+API.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

extension Constants.API {

    static let apiPathVersion = "/api/v1/"

    static let baseUrl = Environment.based(
        staging: "https://nimble-survey-web-staging.herokuapp.com" + apiPathVersion,
        production: "https://survey-api.nimblehq.co" + apiPathVersion
    )
}

extension Constants.Keys {

    static var clientId: String {
        (try? Configuration.value(for: "CLIENT_ID")) ?? ""
    }

    static var clientSecret: String {
        (try? Configuration.value(for: "CLIENT_SECRET")) ?? ""
    }
}
