//
//  AnswerViewModel.swift
//  Survey
//
//  Created by Khanh on 16/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct AnswerViewModel {

    let surveyAnswers: [SurveyAnswer]
}

extension AnswerViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let output = Output()

        Just(surveyAnswers.map { $0.text ?? "" })
            .assign(to: \.answerTitles, on: output)
            .store(in: &output.cancelBag)

        Just(surveyAnswers.map { $0.inputMaskPlaceholder ?? "" })
            .assign(to: \.answerPlaceholders, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension AnswerViewModel {

    final class Input: ObservableObject {

        init() {}
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var answerTitles = [String]()
        @Published var answerPlaceholders = [String]()
    }
}
