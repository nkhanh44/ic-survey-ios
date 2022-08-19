//
//  HomeUseCase.swift
//  Survey
//
//  Created by Khanh on 17/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol HomeUseCaseProtocol {

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Observable<[Survey]>
}

struct HomeUseCase: HomeUseCaseProtocol {

    let surveyRepository: SurveyRepositoryProtocol

    func getSurveyList(pageNumber: Int, pageSize: Int) -> Observable<[Survey]> {
        surveyRepository.getSurveyList(pageNumber: pageNumber, pageSize: pageSize)
    }
}
