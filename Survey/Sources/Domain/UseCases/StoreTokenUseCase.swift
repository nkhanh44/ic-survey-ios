//
//  StoreTokenUseCase.swift
//  Survey
//
//  Created by Khanh on 08/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol StoreTokenUseCaseProtocol {

    func store(token: Token) -> Observable<Bool>
}

struct StoreTokenUseCase: StoreTokenUseCaseProtocol {

    let keychain: KeychainServiceProtocol

    init(keychain: KeychainServiceProtocol = KeychainService.shared) {
        self.keychain = keychain
    }

    func store(token: Token) -> Observable<Bool> {
        try? keychain.removeToken(with: .token)
        try? keychain.set(newToken: KeychainToken(token: token), for: .token)
        let isLoggedIn = (try? keychain.isLoggedIn()) ?? false
        return Just(isLoggedIn).asObservable()
    }
}
