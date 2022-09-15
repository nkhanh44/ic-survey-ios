//
//  UserUseCase.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

protocol UserUseCaseProtocol {

    func getUser() -> Observable<User>
    func logout() -> Observable<Bool>
}

struct UserUseCase: UserUseCaseProtocol {

    let userRepository: UserRepositoryProtocol

    func getUser() -> Observable<User> {
        userRepository.getUser()
    }

    func logout() -> Observable<Bool> {
        userRepository.logout()
    }
}
