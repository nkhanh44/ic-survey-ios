//
//  HomeViewModel.swift
//  SurveyTests
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct HomeViewModel {

    let useCase: HomeUseCaseProtocol
}

extension HomeViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        var pageNumber = 0
        let output = Output()

        input.loadTrigger
            .map { _ in
                self.useCase.getSurveyList(pageNumber: pageNumber + 1, pageSize: 10)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .map {
                pageNumber += 1
                if !UserStorage.cachedSurveyList.hasSameChildren(as: $0 as? [APISurvey] ?? []) {
                    UserStorage.cachedSurveyList = output.surveys + $0 as? [APISurvey] ?? []
                    return output.surveys + $0
                }

                return UserStorage.cachedSurveyList
            }
            .assign(to: \.surveys, on: output)
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

        let loadTrigger: Driver<Void>
        let willGoToDetail: Driver<Void>

        init(
            loadTrigger: Driver<Void>,
            willGoToDetail: Driver<Void>
        ) {
            self.loadTrigger = loadTrigger
            self.willGoToDetail = willGoToDetail
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var alert: AlertMessage?
        @Published var isLoading = false
        @Published var surveys = [Survey]()
        @Published var willGoToDetail = false
    }
}
