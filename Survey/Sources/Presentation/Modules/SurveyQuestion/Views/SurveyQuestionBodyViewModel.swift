//
//  SurveyQuestionBodyViewModel.swift
//  Survey
//
//  Created by Khanh on 16/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SurveyQuestionBodyViewModel {

    var question: SurveyQuestion
    var numberOfQuestions: Int
}

extension SurveyQuestionBodyViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let output = Output()

        input.loadTrigger
            .map { _ in question }
            .compactMap { $0 }
            .assign(to: \.question, on: output)
            .store(in: &output.cancelBag)

        input.loadTrigger
            .map { _ in numberOfQuestions }
            .compactMap { $0 }
            .assign(to: \.numberOfQuestions, on: output)
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

extension SurveyQuestionBodyViewModel {

    final class Input: ObservableObject {

        let loadTrigger: Driver<Void>

        init(loadTrigger: Driver<Void>) {
            self.loadTrigger = loadTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var survey: Survey?
        @Published var alert: AlertMessage?
        @Published var question: SurveyQuestion?
        @Published var numberOfQuestions = 0
    }
}
