//
//  UserUseCaseMock.swift
//  Survey
//
//  Created by Khanh on 13/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

import Combine
import Foundation

final class UserUseCaseMock: UserUseCaseProtocol {

    var getUserCalled = false
    var logoutCalled = false
    var getUserReturnValue = Result<User, Error>.success(APIUser.dummy)
    /// Default is `true`
    var logoutReturnValue = Result<Bool, Error>.success(true)

    func getUser() -> Observable<User> {
        getUserCalled = true
        return getUserReturnValue.publisher.eraseToAnyPublisher()
    }

    func logout() -> Observable<Bool> {
        logoutCalled = true
        return logoutReturnValue.publisher.eraseToAnyPublisher()
    }
}
