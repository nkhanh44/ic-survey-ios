//
//  CachedRepository.swift
//  Survey
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol CachedRepositoryProtocol: AnyObject {

    func getData() -> [Survey]
    func save(data: [Survey])
    func removeData() -> Observable<Bool>
}

final class CachedRepository: CachedRepositoryProtocol {

    private var surveyListStorage: SurveyListCachable!

    required init(surveyListStorage: SurveyListCachable) {
        self.surveyListStorage = surveyListStorage
    }

    func getData() -> [Survey] {
        surveyListStorage.cachedSurveyList
    }

    func save(data: [Survey]) {
        surveyListStorage.cachedSurveyList = data as? [APISurvey] ?? []
    }

    func removeData() -> Observable<Bool> {
        surveyListStorage.cachedSurveyList = []
        return Just(surveyListStorage.cachedSurveyList.isEmpty).asObservable()
    }
}
