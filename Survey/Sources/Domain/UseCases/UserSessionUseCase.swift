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

    let keychain: KeychainServiceProtocol

    init(keychain: KeychainServiceProtocol) {
        self.keychain = keychain
    }

    func hasUserLoggedIn() -> Observable<Bool> {
        let isLoggedIn = (try? keychain.isLoggedIn()) ?? false
        return Just(isLoggedIn).asObservable()
    }
}
