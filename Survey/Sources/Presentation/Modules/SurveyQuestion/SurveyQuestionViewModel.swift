//
//  SurveyQuestionViewModel.swift
//  Survey
//
//  Created by Khanh on 28/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SurveyQuestionViewModel {

    let submitSurveyUseCase: SubmitSurveyUseCaseProtocol
    let id: String
}

extension SurveyQuestionViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()

        input.submitTrigger
            .debounce(
                for: .seconds(1),
                scheduler: DispatchQueue.main
            )
            .filter { _ in
                QuestionSubmissionStorage.shared.getValue().contains(where: {
                    !$0.answers.isEmpty
                })
            }
            .map { _ in
                self.submitSurveyUseCase.submit(
                    id: id,
                    questionSubmissions: QuestionSubmissionStorage.shared.getValue()
                )
                .trackError(errorTracker)
                .trackActivity(activityTracker)
                .asDriver()
            }
            .switchToLatest()
            .compactMap { $0 }
            .assign(to: \.isSuccess, on: output)
            .store(in: &output.cancelBag)

        input.dismissAlert
            .map { _ in nil }
            .assign(to: \.alert, on: output)
            .store(in: &output.cancelBag)

        errorTracker
            .receive(on: RunLoop.main)
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

extension SurveyQuestionViewModel {

    final class Input: ObservableObject {

        let submitTrigger: Driver<Void>
        let dismissAlert: Driver<Void>

        init(
            submitTrigger: Driver<Void>,
            dismissAlert: Driver<Void>
        ) {
            self.submitTrigger = submitTrigger
            self.dismissAlert = dismissAlert
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var alert: AlertMessage?
        @Published var isSuccess: Bool = false
        @Published var isLoading = false
    }
}
