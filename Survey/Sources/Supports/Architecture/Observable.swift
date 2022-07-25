//  swiftlint:disable:this file_name
//  Observable.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

extension Publisher {

    func just(_ output: Output) -> Observable<Output> {
        Just(output)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func empty() -> Observable<Output> {
        return Empty().eraseToAnyPublisher()
    }

    // swiftformat:disable redundantSelf
    func asObservable() -> Observable<Output> {
        self.mapError { $0 }
            .eraseToAnyPublisher()
    }
}
