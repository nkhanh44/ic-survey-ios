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

    var removeSessionCalled = false
    var hasUserLoggedInCalled = false
    /// Default is `true`
    var removeSessionReturnValue = Observable.just(true)
    /// Default is `true`
    var hasUserLoggedInReturnValue = Observable.just(true)

    func removeSession() -> Observable<Bool> {
        removeSessionCalled = true
        return removeSessionReturnValue.asObservable()
    }

    func hasUserLoggedIn() -> Observable<Bool> {
        hasUserLoggedInCalled = true
        return hasUserLoggedInReturnValue.asObservable()
    }
}
