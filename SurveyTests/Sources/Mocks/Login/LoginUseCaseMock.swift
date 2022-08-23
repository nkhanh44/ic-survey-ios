//
//  LoginUseCaseMock.swift
//  SurveyTests
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

import Combine
import Foundation

final class LoginUseCaseMock: LogInUseCaseProtocol {

    var loginCalled = false

    var loginSuccessfullyReturnValue = Result<Token, Error>.success(APIToken.dummy)

    func login(email: String, password: String) -> Observable<Token> {
        loginCalled = true
        return loginSuccessfullyReturnValue.publisher.eraseToAnyPublisher()
    }
}
