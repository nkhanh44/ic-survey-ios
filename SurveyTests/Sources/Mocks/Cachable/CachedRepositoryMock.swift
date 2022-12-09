//
//  CachedRepositoryMock.swift
//  SurveyTests
//
//  Created by Khanh on 08/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
@testable import Survey

final class CachedRepositoryMock: CachedRepositoryProtocol {

    var getDataCalled = false
    var getDataReturnValue = APISurvey.dummyList
    var saveCalled = false
    var removeDataCalled = false
    var removeDataReturnValue = Observable.just(true)
    var dataArgument: [Survey]?

    func getData() -> [Survey] {
        getDataCalled = true
        return getDataReturnValue
    }

    func save(data: [Survey]) {
        saveCalled = true
        dataArgument = data
    }

    func removeData() -> Observable<Bool> {
        removeDataCalled = true
        return removeDataReturnValue.asObservable()
    }
}
