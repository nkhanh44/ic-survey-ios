//
//  ActivityTracker.swift
//  Survey
//
//  Created by Khanh on 25/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

public typealias ActivityTracker = CurrentValueSubject<Bool, Never>

extension Publisher where Failure == Error {

    public func trackActivity(_ activityTracker: ActivityTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveSubscription: { _ in
            activityTracker.send(true)
        }, receiveCompletion: { _ in
            activityTracker.send(false)
        })
        .eraseToAnyPublisher()
    }
}
