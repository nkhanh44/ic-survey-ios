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

    let userSessionUseCase: UserSessionUseCaseProtocol
    let homeUseCase: HomeUseCaseProtocol
}

extension SplashViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()

        input.loadTrigger
            .map {
                self.userSessionUseCase.hasUserLoggedIn()
                    .asDriver()
            }
            .switchToLatest()
            .assign(to: \.hasUserLoggedIn, on: output)
            .store(in: &output.cancelBag)

        input.willFetchSurveysTrigger
            .map { _ in
                self.homeUseCase.getSurveyList(pageNumber: 1, pageSize: 10)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .map {
                guard let list = $0 as? [APISurvey] else {
                    return false
                }
                CachedUserStorage.shared.set(objects: list)
                return true
            }
            .assign(to: \.fetchSuccessfully, on: output)
            .store(in: &output.cancelBag)

        errorTracker
            .receive(on: RunLoop.main)
            .filter { ($0 as? SError) != .empty }
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: &output.cancelBag)

        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension SplashViewModel {

    final class Input: ObservableObject {

        let willFetchSurveysTrigger: Driver<Void>
        let loadTrigger: Driver<Void>

        init(
            loadTrigger: Driver<Void>,
            willFetchSurveysTrigger: Driver<Void>
        ) {
            self.willFetchSurveysTrigger = willFetchSurveysTrigger
            self.loadTrigger = loadTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var hasUserLoggedIn = false
        @Published var alert: AlertMessage?
        @Published var isLoading = false
        @Published var fetchSuccessfully = false
    }
}
