//
//  UserSessionUseCase.swift
//  Survey
//
//  Created by Khanh on 16/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol UserSessionUseCaseProtocol {

    func hasUserLoggedIn() -> Observable<Bool>
}

struct UserSessionUseCase: UserSessionUseCaseProtocol {

    func hasUserLoggedIn() -> Observable<Bool> {
        let keychain = KeychainService.shared
        let isLoggedIn = (try? keychain.isLoggedIn()) ?? false
        return Just(isLoggedIn).asObservable()
    }
}
