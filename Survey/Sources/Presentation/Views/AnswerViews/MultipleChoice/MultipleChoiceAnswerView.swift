//
//  MultipleChoiceAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct MultipleChoiceAnswerView: View {

    @ObservedObject var input: AnswerViewModel.Input
    @ObservedObject var output: AnswerViewModel.Output
    @State var answers: [Bool]
    private let selectedAnswersTrigger = PassthroughSubject<[SelectedAnswer]?, Never>()

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            ForEach(output.answerTitles.indices, id: \.self) { index in
                MultipleSelectionView(
                    title: output.answerTitles[index],
                    selected: $answers[index]
                )
                .padding()
                .onChange(of: answers[index]) { newValue in
                    selectedAnswersTrigger.send(
                        [
                            SelectedAnswer(
                                index: index
                            )
                        ]
                    )
                }

                if output.answerTitles[index] != output.answerTitles.last {
                    Divider()
                        .background(.white)
                }
            }
        }
        .background(.clear)
    }

    init(
        viewModel: AnswerViewModel,
        answers: [Bool]
    ) {
        let input = AnswerViewModel.Input(selectedAnswers: selectedAnswersTrigger.asDriver())
        output = viewModel.transform(input)
        self.answers = answers
        self.input = input
    }
}
