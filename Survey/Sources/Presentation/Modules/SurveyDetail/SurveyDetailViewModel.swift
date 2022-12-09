//
//  SurveyDetailViewModel.swift
//  Survey
//
//  Created by Khanh on 22/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SurveyDetailViewModel {

    let surveyQuestionUseCase: SurveyQuestionUseCaseProtocol
}

extension SurveyDetailViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()

        input.startSurveyTrigger
            .map {
                self.surveyQuestionUseCase.getSurveyDetail(id: $0)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .compactMap { $0 }
            .assign(to: \.survey, on: output)
            .store(in: &output.cancelBag)

        input.willShowQuestions
            .assign(to: \.isSurveyQuestionPresented, on: output)
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

extension SurveyDetailViewModel {

    final class Input: ObservableObject {

        let startSurveyTrigger: Driver<String>
        let willShowQuestions: Driver<Bool>
        let dismissAlert: Driver<Void>

        init(
            startSurveyTrigger: Driver<String>,
            willShowQuestions: Driver<Bool>,
            dismissAlert: Driver<Void>
        ) {
            self.startSurveyTrigger = startSurveyTrigger
            self.willShowQuestions = willShowQuestions
            self.dismissAlert = dismissAlert
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var survey: Survey?
        @Published var isLoading = false
        @Published var alert: AlertMessage?
        @Published var isSurveyQuestionPresented = false
    }
}
