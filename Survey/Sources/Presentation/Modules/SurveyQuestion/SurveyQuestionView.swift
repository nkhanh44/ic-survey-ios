//
//  SurveyQuestionView.swift
//  Survey
//
//  Created by Khanh on 23/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SurveyQuestionView: View {

    @Binding var isPresented: Bool
    var questions: [SurveyQuestion]

    var body: some View {
        LoadingView(
            isShowing: .constant(false),
            text: .constant(""),
            content: {
                TabView {
                    ForEach(Array(questions.enumerated()), id: \.element.id) { question in
                        SurveyQuestionBodyView(
                            viewModel: SurveyQuestionBodyViewModel(
                                question: question.element,
                                numberOfQuestions: questions.count
                            )
                        )
                    }
                }
                .padding(.top, 60.0)
                .padding(.bottom, 60.0)
                .tabViewStyle(
                    PageTabViewStyle(
                        indexDisplayMode: .never
                    )
                )
            }
        )
        .overlay {
            setUpCloseButton()
            setUpNextQuestionButton()
        }
        .padding(.bottom, 54.0)
        .padding(.top, 54.0)
        .background(
            // TODO: Remove dummy cover image url
            Image(questions[0].coverImageUrl)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.6)
        )
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }

    private func setUpCloseButton() -> some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    Spacer()

                    Button("") {}
                        .modifier(
                            CloseButtonModifier(
                                didAction: {
                                    withoutAnimation {
                                        isPresented = false
                                    }
                                }
                            )
                        )
                        .padding(.trailing, 20.0)
                }
                Spacer()
            }
        }
    }

    private func setUpNextQuestionButton() -> some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()

                HStack {
                    Spacer()

                    ZStack(alignment: .trailing) {
                        Button("") {}
                            .modifier(
                                CircleButtonModifier(
                                    didAction: {}
                                )
                            )

                        SButtonView(
                            isValid: .constant(true),
                            action: {},
                            title: "Submit"
                        )
                        .frame(
                            width: 120.0,
                            height: 56.0
                        )
                        .hidden()
                    }
                    .padding(.trailing, 20.0)
                }
            }
        }
    }
}
