//
//  LoginRepositoryMock.swift
//  SurveyTests
//
//  Created by Khanh on 08/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
@testable import Survey

final class LoginRepositoryMock: LogInRepositoryProtocol {

    var loginCalled = false
    var loginReturnValue = Observable.just(APIToken.dummy)

    func login(email: String, password: String) -> Observable<Token> {
        loginCalled = true
        return loginReturnValue.map { $0 as Token }.asObservable()
    }
}
