//
//  SurveyQuestionUseCase.swift
//  Survey
//
//  Created by Khanh on 23/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

protocol SurveyQuestionUseCaseProtocol {

    func getSurveyDetail(id: String) -> Observable<Survey>
}

struct SurveyQuestionUseCase: SurveyQuestionUseCaseProtocol {

    let surveyRepository: SurveyRepositoryProtocol

    func getSurveyDetail(id: String) -> Observable<Survey> {
        surveyRepository.getSurveyDetail(id: id)
    }
}
