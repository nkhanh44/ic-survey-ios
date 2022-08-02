//
//  LogInUseCase.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol LogInUseCaseType {

    func login(email: String, password: String) -> Observable<APIToken>
}

struct LogInUseCase: LogInUseCaseType {

    var loginRepository: LogInRepositoryType

    func login(email: String, password: String) -> Observable<APIToken> {
        loginRepository
            .login(email: email, password: password)
            .eraseToAnyPublisher()
    }
}
