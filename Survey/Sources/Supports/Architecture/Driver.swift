//
//  Driver.swift
//  Survey
//
//  Created by Khanh on 25/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Foundation

public typealias Driver<T> = AnyPublisher<T, Never>

extension Publisher {

    public static func just(_ output: Output) -> Driver<Output> {
        return Just(output).eraseToAnyPublisher()
    }

    public static func empty() -> Driver<Output> {
        return Empty().eraseToAnyPublisher()
    }

    public func asDriver() -> Driver<Output> {
        return self.catch { _ in Empty() }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
