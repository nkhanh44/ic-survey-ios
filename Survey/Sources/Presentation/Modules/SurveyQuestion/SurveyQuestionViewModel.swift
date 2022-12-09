//  swiftlint:disable function_body_length
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
    let submissionStorageUseCase: SubmissionStorageUseCaseProtocol
    let id: String
}

extension SurveyQuestionViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()

        input.onAppearTrigger
            .map {
                _ = submissionStorageUseCase.delete()
                submissionStorageUseCase.store(data: $0
                    .map {
                        QuestionSubmission(
                            id: $0.id,
                            answers: []
                        )
                    }
                )
            }
            .assign(to: \.done, on: output)
            .store(in: &output.cancelBag)

        input.clearSubmissionTrigger
            .map { _ in
                _ = submissionStorageUseCase.delete()
            }
            .assign(to: \.done, on: output)
            .store(in: &output.cancelBag)

        input.submitTrigger
            .map { _ in submissionStorageUseCase.load() }
            .filter { data in
                data.contains(where: {
                    !$0.answers.isEmpty
                })
            }
            .map { data in
                self.submitSurveyUseCase.submit(
                    id: id,
                    questionSubmissions: data
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
        let clearSubmissionTrigger: Driver<Void>
        let onAppearTrigger: Driver<[SurveyQuestion]>

        init(
            submitTrigger: Driver<Void>,
            dismissAlert: Driver<Void>,
            clearSubmissionTrigger: Driver<Void>,
            onAppearTrigger: Driver<[SurveyQuestion]>
        ) {
            self.submitTrigger = submitTrigger
            self.dismissAlert = dismissAlert
            self.clearSubmissionTrigger = clearSubmissionTrigger
            self.onAppearTrigger = onAppearTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var alert: AlertMessage?
        @Published var isSuccess: Bool = false
        @Published var isLoading = false
        @Published var done: () = ()
    }
}
