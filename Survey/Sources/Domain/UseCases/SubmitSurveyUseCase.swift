//
//  SubmitSurveyUseCase.swift
//  Survey
//
//  Created by Khanh on 24/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

protocol SubmitSurveyUseCaseProtocol {

    func submit(id: String, questionSubmissions: [QuestionSubmission]) -> Observable<Bool>
}

struct SubmitSurveyUseCase: SubmitSurveyUseCaseProtocol {

    let surveyRepository: SurveyRepositoryProtocol

    func submit(
        id: String,
        questionSubmissions: [QuestionSubmission]
    ) -> Observable<Bool> {
        surveyRepository.submit(
            id: id,
            questionSubmissions: questionSubmissions
        )
    }
}
