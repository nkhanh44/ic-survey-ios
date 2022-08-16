//
//  UserSessionUseCaseMock.swift
//  SurveyTests
//
//  Created by Khanh on 16/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

import Combine

final class UserSessionUseCaseMock: UserSessionUseCaseProtocol {

    var hasUserLoggedInCalled = false

    var hasUserLoggedInReturnValue = Observable.just(true)

    func hasUserLoggedIn() -> Observable<Bool> {
        hasUserLoggedInCalled = true
        return hasUserLoggedInReturnValue.asObservable()
    }
}
