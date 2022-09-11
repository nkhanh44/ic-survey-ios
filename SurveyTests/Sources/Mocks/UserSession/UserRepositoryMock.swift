//
//  UserRepositoryMock.swift
//  Survey
//
//  Created by Khanh on 13/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
@testable import Survey

final class UserRepositoryMock: UserRepositoryProtocol {

    var getUserCalled = false
    var logoutCalled = false
    var getUserReturnValue = Observable.just(APIUser.dummy)
    /// Default is `true`
    var logoutReturnValue = Observable.just(true)

    func getUser() -> Observable<User> {
        getUserCalled = true
        return getUserReturnValue.map { $0 as User }.asObservable()
    }

    func logout() -> Observable<Bool> {
        logoutCalled = true
        return logoutReturnValue.asObservable()
    }
}
