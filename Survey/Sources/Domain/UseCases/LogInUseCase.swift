//
//  LogInUseCase.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol LogInUseCaseProtocol {

    func login(email: String, password: String) -> Observable<Token>
}

struct LogInUseCase: LogInUseCaseProtocol {

    var loginRepository: LogInRepositoryProtocol

    func login(email: String, password: String) -> Observable<Token> {
        loginRepository
            .login(email: email, password: password)
            .eraseToAnyPublisher()
    }
}
