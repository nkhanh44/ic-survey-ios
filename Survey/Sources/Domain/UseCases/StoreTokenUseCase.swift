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

    func store(token: Token) -> Observable<Bool> {
        KeychainAccess.remove()
        KeychainAccess.token = token as? KeychainToken
        return Just(KeychainAccess.isLoggedIn).asObservable()
    }
}
