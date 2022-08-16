//
//  SplashViewModel.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SplashViewModel {

    let useCase: UserSessionUseCaseProtocol
}

extension SplashViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let output = Output()

        input.loadTrigger
            .map {
                self.useCase.hasUserLoggedIn()
                    .asDriver()
            }
            .switchToLatest()
            .assign(to: \.hasUserLoggedIn, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension SplashViewModel {

    struct Input {

        let loadTrigger: Driver<Void>

        init(loadTrigger: Driver<Void>) {
            self.loadTrigger = loadTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var hasUserLoggedIn = false
    }
}
