//
//  MultipleChoiceAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct MultipleChoiceAnswerView: View {

    @ObservedObject var input: AnswerViewModel.Input
    @ObservedObject var output: AnswerViewModel.Output

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            ForEach(output.answerTitles, id: \.self) { item in
                MultipleSelectionView(title: item)
                    .padding()

                if item != output.answerTitles.last {
                    Divider()
                        .background(.white)
                }
            }
        }
        .background(.clear)
    }

    init(viewModel: AnswerViewModel) {
        let input = AnswerViewModel.Input()
        output = viewModel.transform(input)
        self.input = input
    }
}
