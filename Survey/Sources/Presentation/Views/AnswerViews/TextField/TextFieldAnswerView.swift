//
//  TextFieldAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct TextFieldAnswerView: View {

    @ObservedObject var input: AnswerViewModel.Input
    @ObservedObject var output: AnswerViewModel.Output

    var isMultipleLines: Bool
    @State var answers: [String]
    private let selectedAnswersTrigger = PassthroughSubject<[SelectedAnswer]?, Never>()

    var body: some View {
        VStack {
            if isMultipleLines {
                STextEditorView(
                    placeholder: output.answerTitles.first ?? "",
                    text: $answers.first ?? .constant("")
                )
                .onChange(of: answers, perform: { _ in
                    selectedAnswersTrigger.send([SelectedAnswer(index: 0, text: answers.first)])
                })
                .font(.body)
                .background(.gray.opacity(0.2))
                .accentColor(.stoneGray)
                .frame(height: 168.0)
                .cornerRadius(10.0)
            } else {
                ForEach(output.answerTitles.indices, id: \.self) { index in
                    TextField("", text: $answers[index])
                        .modifier(
                            TextFieldAnswerModifier(
                                showPlaceholder: answers[index].isEmpty,
                                placeholder: output.answerTitles[index]
                            )
                        )
                        .onChange(of: answers[index], perform: { newValue in
                            selectedAnswersTrigger.send(
                                [
                                    SelectedAnswer(
                                        index: index,
                                        text: newValue
                                    )
                                ]
                            )
                        })
                        .tag(index)
                        .padding(.bottom, 16.0)
                }
            }
        }
        .padding()
    }

    init(viewModel: AnswerViewModel, isMultipleLines: Bool) {
        let input = AnswerViewModel.Input(selectedAnswers: selectedAnswersTrigger.asDriver())
        output = viewModel.transform(input)
        self.isMultipleLines = isMultipleLines
        if !isMultipleLines {
            answers = [String](
                repeating: "",
                count: viewModel.surveyAnswers.count
            )
        } else {
            answers = [""]
        }

        self.input = input
    }
}
