//
//  SurveyDetailViewModel.swift
//  Survey
//
//  Created by Khanh on 22/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SurveyDetailViewModel {}

extension SurveyDetailViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let output = Output()

        input.nextToSurveyQuestionTrigger
            .map { true }
            .assign(to: \.didNextSuccessfully, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension SurveyDetailViewModel {

    final class Input: ObservableObject {

        let nextToSurveyQuestionTrigger: Driver<Void>

        init(nextToSurveyQuestionTrigger: Driver<Void>) {
            self.nextToSurveyQuestionTrigger = nextToSurveyQuestionTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var didNextSuccessfully = false
    }
}
