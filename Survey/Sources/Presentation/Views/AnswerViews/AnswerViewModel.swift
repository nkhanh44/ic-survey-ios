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
    let displayType: DisplayType
    let pickType: PickType
    let idQuestion: String
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

        input.npsRatingTrigger?
            .compactMap { ($0 < 5) && ($0 >= 0) ? 1.0 : 0.5 }
            .assign(to: \.notLikelyLabelOpacity, on: output)
            .store(in: &output.cancelBag)

        input.npsRatingTrigger?
            .compactMap { $0 >= 5 ? 1.0 : 0.5 }
            .assign(to: \.likelyLabelOpacity, on: output)
            .store(in: &output.cancelBag)

        input.selectedAnswers
            .compactMap { $0 }
            .map { anwsers in
                let isMultipleChoices = ((displayType == .choice && pickType == .any) || displayType == .textfield)
                var submission = UserStorage.questionsSubmission
                if isMultipleChoices {
                    let id = surveyAnswers[anwsers.first?.index ?? 0].id
                    for index in 0 ..< submission.count where submission[index].id == idQuestion {
                        if submission[index].answers.contains(where: { $0.id == id }) {
                            guard displayType != .choice else {
                                if let removedIndex = submission[index].answers.firstIndex(where: { $0.id == id }) {
                                    submission[index].answers.remove(at: removedIndex)
                                }
                                continue
                            }
                            if let addedIndex = submission[index].answers.firstIndex(where: { $0.id == id }) {
                                submission[index].answers[addedIndex] = AnswerSubmission(
                                    id: surveyAnswers[anwsers[0].index].id,
                                    answer: anwsers[0].text
                                )
                            }
                        } else {
                            submission[index].answers += anwsers.map {
                                AnswerSubmission(
                                    id: surveyAnswers[$0.index].id,
                                    answer: $0.text
                                )
                            }
                        }
                    }
                } else {
                    for index in 0 ..< submission.count where submission[index].id == idQuestion {
                        guard displayType == .choice && anwsers[0].index == -1 else {
                            submission[index].answers = anwsers.map {
                                AnswerSubmission(
                                    id: surveyAnswers[$0.index].id,
                                    answer: $0.text
                                )
                            }
                            continue
                        }
                        submission[index].answers.removeFirst()
                    }
                }
                UserStorage.questionsSubmission = submission
                print("@@@ list", UserStorage.questionsSubmission)
            }
            .map { _ in true }
            .assign(to: \.didAnswer, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension AnswerViewModel {

    final class Input: ObservableObject {

        let npsRatingTrigger: Driver<Int>?
        let selectedAnswers: Driver<[SelectedAnswer]?>

        init(
            npsRatingTrigger: Driver<Int>? = nil,
            selectedAnswers: Driver<[SelectedAnswer]?>
        ) {
            self.npsRatingTrigger = npsRatingTrigger
            self.selectedAnswers = selectedAnswers
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var answerTitles = [String]()
        @Published var answerPlaceholders = [String]()
        @Published var notLikelyLabelOpacity = 0.5
        @Published var likelyLabelOpacity = 0.5
        @Published var didAnswer = false
    }
}
