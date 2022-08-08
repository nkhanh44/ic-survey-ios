//
//  StoreTokenUseCaseMock.swift
//  SurveyTests
//
//  Created by Khanh on 08/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

@testable import Survey

import Combine

final class StoreTokenUseCaseMock: StoreTokenUseCaseProtocol {

    var storeCalled = false

    var storeReturnValue = Result<Bool, Error>.success(true)

    func store(token: Token) -> Observable<Bool> {
        storeCalled = true
        return storeReturnValue.publisher.eraseToAnyPublisher()
    }
}
