//
//  SurveyRepository.swift
//  Survey
//
//  Created by Khanh on 12/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol SurveyRepositoryProtocol: AnyObject {

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Observable<[Survey]>
}

final class SurveyRepository: SurveyRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol!

    required init(api: NetworkAPIProtocol) {
        networkAPI = api
    }

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Observable<[Survey]> {
        let requesConfiguration = SurveyRequestConfiguration
            .getSurveyList(
                pageNumber: pageNumber,
                pageSize: pageSize
            )

        return networkAPI.performRequest(requesConfiguration)
            .map { $0 as [APISurvey] }
            .eraseToAnyPublisher()
    }
}
