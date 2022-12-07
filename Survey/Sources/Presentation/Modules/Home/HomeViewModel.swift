// swiftlint:disable function_body_length
//  HomeViewModel.swift
//  SurveyTests
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct HomeViewModel {

    let homeUseCase: HomeUseCaseProtocol
    let userUseCase: UserUseCaseProtocol
    let userSessionUseCase: UserSessionUseCaseProtocol
    let cachedStorageUseCase: CachedStorageUseCaseProtocol
}

extension HomeViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        var pageNumber = 0
        let output = Output()

        input.loadUserInfoTrigger
            .map { _ in
                self.userUseCase.getUser()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .compactMap { $0 }
            .assign(to: \.user, on: output)
            .store(in: &output.cancelBag)

        input.loadTrigger
            .map { _ in
                self.homeUseCase.getSurveyList(pageNumber: pageNumber + 1, pageSize: 10)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .map { (cachedStorageUseCase.load(), $0) }
            .map { args in
                let (cachedSurveys, resultSurveys) = args as? ([APISurvey], [APISurvey]) ?? ([], [])
                pageNumber += 1
                if !cachedSurveys.hasSameChildren(as: resultSurveys) {
                    cachedStorageUseCase.store(data: output.surveys + resultSurveys as? [APISurvey] ?? [])
                    return output.surveys + resultSurveys
                }

                return cachedSurveys
            }
            .assign(to: \.surveys, on: output)
            .store(in: &output.cancelBag)

        input.reloadTrigger
            .map { _ in
                self.homeUseCase.getSurveyList(pageNumber: 1, pageSize: 10)
                    .trackError(errorTracker)
                    .asDriver()
            }
            .switchToLatest()
            .map {
                pageNumber = 1
                if !$0.isEmpty {
                    cachedStorageUseCase.store(data: $0 as? [APISurvey] ?? [])
                }

                return cachedStorageUseCase.load()
            }
            .assign(to: \.surveys, on: output)
            .store(in: &output.cancelBag)

        input.logoutTrigger
            .map { _ in
                self.userUseCase.logout()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .map { _ in
                userSessionUseCase.removeSession().asDriver()
            }
            .switchToLatest()
            .assign(to: \.didLogoutSuccessfully, on: output)
            .store(in: &output.cancelBag)

        input.willGoToDetail
            .map { true }
            .assign(to: \.willGoToDetail, on: output)
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

extension HomeViewModel {

    final class Input: ObservableObject {

        let loadUserInfoTrigger: Driver<Void>
        let loadTrigger: Driver<Void>
        let willGoToDetail: Driver<Void>
        let logoutTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>

        init(
            loadUserInfoTrigger: Driver<Void>,
            loadTrigger: Driver<Void>,
            willGoToDetail: Driver<Void>,
            logoutTrigger: Driver<Void>,
            reloadTrigger: Driver<Void>
        ) {
            self.loadUserInfoTrigger = loadUserInfoTrigger
            self.loadTrigger = loadTrigger
            self.willGoToDetail = willGoToDetail
            self.logoutTrigger = logoutTrigger
            self.reloadTrigger = reloadTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var alert: AlertMessage?
        @Published var isLoading = false
        @Published var surveys = [Survey]()
        @Published var willGoToDetail = false
        @Published var user: User?
        @Published var didLogoutSuccessfully = false
    }
}
