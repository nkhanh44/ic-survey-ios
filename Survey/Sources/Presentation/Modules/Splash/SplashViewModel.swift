//
//  SplashViewModel.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SplashViewModel {}

extension SplashViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()
        var cancelBag = CancelBag()

        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: &cancelBag)

        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: &cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension SplashViewModel {

    struct Input {

        let loadTrigger: Driver<Void>
    }

    final class Output: ObservableObject {

        @Published var alert: AlertMessage?
        @Published var isLoading = false
    }
}
