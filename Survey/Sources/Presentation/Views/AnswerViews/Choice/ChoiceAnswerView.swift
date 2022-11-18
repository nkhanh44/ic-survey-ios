//
//  ChoiceAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct ChoiceAnswerView: View {

    @ObservedObject var input: AnswerViewModel.Input
    @ObservedObject var output: AnswerViewModel.Output

    var body: some View {
        ZStack {
            if !output.answerTitles.isEmpty {
                PickerView(
                    selections: .constant([output.answerTitles.count]),
                    data: [output.answerTitles]
                )
                .background(.clear)
                .overlay {
                    Spacer()
                        .frame(height: 56.0)
                        .padding(.horizontal, 30.0)
                        .overlay(Divider().background(.white), alignment: .top)
                        .overlay(Divider().background(.white), alignment: .bottom)
                }
            }
        }
    }

    init(viewModel: AnswerViewModel) {
        let input = AnswerViewModel.Input()
        output = viewModel.transform(input)
        self.input = input
    }
}
