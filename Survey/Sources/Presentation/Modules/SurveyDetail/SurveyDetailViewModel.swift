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

        input.startSurveyTrigger
            .map { true }
            .assign(to: \.willGoToNextSurvey, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension SurveyDetailViewModel {

    final class Input: ObservableObject {

        let startSurveyTrigger: Driver<Void>

        init(startSurveyTrigger: Driver<Void>) {
            self.startSurveyTrigger = startSurveyTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var willGoToNextSurvey = false
    }
}
