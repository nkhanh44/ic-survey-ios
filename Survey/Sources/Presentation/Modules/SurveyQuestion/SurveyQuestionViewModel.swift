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
        let output = Output()

        input.submitTrigger
            .map { _ in
                self.submitSurveyUseCase.submit(
                    id: id,
                    questionSubmissions: UserStorage.questionsSubmission
                )
                .trackError(errorTracker)
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
    }
}
