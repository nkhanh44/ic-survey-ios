//
//  SurveyRequestConfiguration.swift
//  Survey
//
//  Created by Khanh on 12/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire

enum SurveyRequestConfiguration {

    static func getSurveyList(pageNumber: Int, pageSize: Int) -> RequestConfiguration {
        RequestConfiguration(
            endpoint: "surveys",
            method: .get,
            encoding: URLEncoding.default,
            parameters: [
                "page[number]": pageNumber,
                "page[size]": pageSize
            ]
        )
    }

    static func getSurveyDetail(id: String) -> RequestConfiguration {
        RequestConfiguration(
            endpoint: "surveys/\(id)",
            method: .get,
            encoding: URLEncoding.default
        )
    }
}
