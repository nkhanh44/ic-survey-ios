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
    func getSurveyDetail(id: String) -> Observable<Survey>
    func submit(id: String, questionSubmissions: [QuestionSubmission]) -> Observable<Bool>
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

    func getSurveyDetail(id: String) -> Observable<Survey> {
        networkAPI
            .performRequest(
                SurveyRequestConfiguration.getSurveyDetail(id: id)
            )
            .map { $0 as APISurvey }
            .eraseToAnyPublisher()
    }

    func submit(id: String, questionSubmissions: [QuestionSubmission]) -> Observable<Bool> {
        networkAPI
            .performRequest(
                SurveyRequestConfiguration.submit(
                    id: id,
                    questionSubmissions: questionSubmissions.map {
                        APIQuestionSubmission(questionSubmission: $0)
                    }
                )
            )
            .eraseToAnyPublisher()
    }
}
