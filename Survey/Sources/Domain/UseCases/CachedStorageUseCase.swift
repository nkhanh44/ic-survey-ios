//
//  CachedStorageUseCase.swift
//  Survey
//
//  Created by Khanh on 07/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol CachedStorageUseCaseProtocol {

    func store(data: [Survey])
    func load() -> [Survey]
    func delete() -> Observable<Bool>
}

final class CachedStorageUseCase: CachedStorageUseCaseProtocol {

    var surveyListStorage: SurveyListCachable

    init(surveyListStorage: SurveyListCachable = SurveyListStorage()) {
        self.surveyListStorage = surveyListStorage
    }

    func store(data: [Survey]) {
        surveyListStorage.cachedSurveyList = data as? [APISurvey] ?? []
    }

    func load() -> [Survey] {
        surveyListStorage.cachedSurveyList
    }

    func delete() -> Observable<Bool> {
        surveyListStorage.cachedSurveyList = []
        return Just(surveyListStorage.cachedSurveyList.isEmpty).asObservable()
    }
}
