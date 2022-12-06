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
            .map { answer in
                let isMultipleChoices = ((displayType == .choice && pickType == .any) || displayType == .textfield)
                handleSelectedAnswers(isMultipleChoices: isMultipleChoices, selectedAnswer: answer)
            }
            .map { _ in true }
            .assign(to: \.didAnswer, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Private

extension AnswerViewModel {

    private func handleSelectedAnswers(isMultipleChoices: Bool, selectedAnswer: SelectedAnswer) {
        var submission = QuestionSubmissionStorage.shared.getValue()
        for index in 0 ..< submission.count where submission[index].id == idQuestion {
            if isMultipleChoices {
                submission = handleMultipleChoices(
                    submission: submission,
                    index: index,
                    selectedAnswer: selectedAnswer,
                    id: surveyAnswers[selectedAnswer.index].id
                )
            } else {
                guard displayType == .choice, selectedAnswer.index == -1 else {
                    // Add answer to storage
                    submission[index].answers = [
                        AnswerSubmission(
                            id: surveyAnswers[selectedAnswer.index].id,
                            answer: selectedAnswer.text
                        )
                    ]
                    continue
                }
                submission[index].answers.removeFirst() // Remove answer when we want to undo the choice
            }
        }
        QuestionSubmissionStorage.shared.set(objects: submission)
    }

    private func handleMultipleChoices(
        submission: [QuestionSubmission],
        index: Int,
        selectedAnswer: SelectedAnswer,
        id: String
    ) -> [QuestionSubmission] {
        var tempSubmission = submission

        if let selectedIndex = tempSubmission[index].answers.firstIndex(where: { $0.id == id }) {
            // When there is an already answer, remove the answer if we want to undo the choice
            guard displayType != .choice else {
                tempSubmission[index].answers.remove(at: selectedIndex)
                return tempSubmission
            }
            // When there is an already answer, we modify it in the storage
            tempSubmission[index].answers[selectedIndex] = AnswerSubmission(
                id: id,
                answer: selectedAnswer.text
            )
        } else {
            // When there is no answer yet, we add it to the storage
            tempSubmission[index].answers += [
                AnswerSubmission(
                    id: id,
                    answer: selectedAnswer.text
                )
            ]
        }
        return tempSubmission
    }
}

// MARK: - Input & Output

extension AnswerViewModel {

    final class Input: ObservableObject {

        let npsRatingTrigger: Driver<Int>?
        let selectedAnswers: Driver<SelectedAnswer?>

        init(
            npsRatingTrigger: Driver<Int>? = nil,
            selectedAnswers: Driver<SelectedAnswer?>
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
