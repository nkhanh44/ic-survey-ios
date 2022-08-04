//
//  LogInRepository.swift
//  Survey
//
//  Created by Khanh on 01/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

protocol LogInRepositoryProtocol: AnyObject {

    func login(email: String, password: String) -> Observable<APIToken>
}

final class LogInRepository: LogInRepositoryProtocol {

    private var networkAPI: NetworkAPIProtocol!

    required init(api: NetworkAPIProtocol) {
        networkAPI = api
    }

    func login(email: String, password: String) -> Observable<APIToken> {
        let requestConfiguration = LogInRequestConfiguration.login(email: email, password: password)
        return networkAPI.performRequest(requestConfiguration)
            .map { $0 as APIToken }
            .eraseToAnyPublisher()
    }
}
