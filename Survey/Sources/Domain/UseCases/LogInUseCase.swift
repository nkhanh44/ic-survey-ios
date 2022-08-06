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

    func login(email: String, password: String) -> Observable<Bool>
}

struct LogInUseCase: LogInUseCaseProtocol {

    var loginRepository: LogInRepositoryProtocol

    func login(email: String, password: String) -> Observable<Bool> {
        loginRepository
            .login(email: email, password: password)
            .map { token in
                KeychainAccess.remove()
                KeychainAccess.token = token as? KeychainToken
                return KeychainAccess.isLoggedIn
            }
            .eraseToAnyPublisher()
    }
}
