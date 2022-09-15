//
//  UserRepository.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol UserRepositoryProtocol: AnyObject {

    func getUser() -> Observable<User>
    func logout() -> Observable<Bool>
}

final class UserRepository: UserRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol!

    required init(api: NetworkAPIProtocol) {
        networkAPI = api
    }

    func getUser() -> Observable<User> {
        networkAPI.performRequest(UserRequestConfiguration.getUser())
            .map { $0 as APIUser }
            .eraseToAnyPublisher()
    }

    func logout() -> Observable<Bool> {
        networkAPI.performEmptyRequest(UserRequestConfiguration.logout())
            .map { $0 as Bool }
            .eraseToAnyPublisher()
    }
}
