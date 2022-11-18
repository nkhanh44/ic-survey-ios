//
//  SurveyQuestionBodyView.swift
//  Survey
//
//  Created by Khanh on 23/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SurveyQuestionBodyView: View {

    @ObservedObject var input: SurveyQuestionBodyViewModel.Input
    @ObservedObject var output: SurveyQuestionBodyViewModel.Output

    private let loadTrigger = PassthroughSubject<Void, Never>()

    var body: some View {
        VStack(alignment: .leading) {
            // MARK: - Remove dummy
            Text("x/x")
                .modifier(SmallTagTextModifier())
                .padding(.bottom, 10.0)

            Text("Question")
                .modifier(LargerTitleTextModifier())
                .padding(.bottom, 10.0)

            setUpAnswer()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
        }
        .onAppear {
            loadTrigger.send()
        }
        .padding(.leading, 10.0)
        .padding(.trailing, 10.0)
        .edgesIgnoringSafeArea(.all)
    }

    init(
        viewModel: SurveyQuestionBodyViewModel
    ) {
        let input = SurveyQuestionBodyViewModel.Input(
            loadTrigger: loadTrigger.asDriver()
        )
        output = viewModel.transform(input)
        self.input = input
    }
}

extension SurveyQuestionBodyView {

    private func setUpAnswer() -> some View {
        VStack {
            let viewModel = AnswerViewModel(surveyAnswers: output.question?.answers ?? [])
            let displayType = output.question?.displayType
            switch displayType {
            case .star, .heart, .smiley:
                RatingAnswerView(
                    viewModel: viewModel,
                    displayType: displayType ?? .smiley
                )
            case .nps:
                NPSAnswerView(viewModel: viewModel)
            case .textarea, .textfield:
                TextFieldAnswerView(
                    viewModel: viewModel,
                    isMultipleLines: displayType == .textarea
                )
            case .choice, .dropdown, .intro, .outro:
                switch output.question?.pick ?? .none {
                case .any:
                    MultipleChoiceAnswerView(viewModel: viewModel)
                case .one, .none:
                    ChoiceAnswerView(viewModel: viewModel)
                }
            case .none: EmptyView()
            }
        }
    }
}
