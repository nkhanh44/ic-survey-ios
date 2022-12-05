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

    @ObservedObject var input: SurveyQuestionViewModel.Input
    @ObservedObject var output: SurveyQuestionViewModel.Output
    @State var answers = [SelectedAnswer]()
    @State var tabSelection = 0

    var isPresented: Binding<Bool>
    var questions: [SurveyQuestion]
    private let submitTrigger = PassthroughSubject<Void, Never>()
    private let dismissAlertTrigger = PassthroughSubject<Void, Never>()
    private let minDragTranslationForSwipe: CGFloat = 30.0

    var body: some View {
        LoadingView(
            isShowing: .constant(false),
            text: .constant(""),
            content: {
                TabView(selection: $tabSelection) {
                    ForEach(Array(questions.enumerated()), id: \.element.id) { question in
                        SurveyQuestionBodyView(
                            viewModel: SurveyQuestionBodyViewModel(
                                question: question.element,
                                numberOfQuestions: questions.count
                            )
                        )
                        .tag(question.offset)
                        .contentShape(Rectangle())
                        .highPriorityGesture(DragGesture().onEnded {
                            handleSwipe(translation: $0.translation.width)
                        })
                        .clipped()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .padding(.top, 60.0)
                .padding(.bottom, 60.0)
            }
        )
        .overlay {
            setUpCloseButton()
            setUpNextQuestionButton()
        }
        .padding(.bottom, 54.0)
        .padding(.top, 54.0)
        .background(
            setUpBackground()
                .opacity(0.6)
        )
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
        .onAppear {
            UserStorage.questionsSubmission = []
            UserStorage.questionsSubmission = questions
                .map {
                    QuestionSubmission(
                        id: $0.id,
                        answers: []
                    )
                }
        }
    }

    init(
        viewModel: SurveyQuestionViewModel,
        isPresented: Binding<Bool>,
        questions: [SurveyQuestion]
    ) {
        self.isPresented = isPresented
        self.questions = questions
        let input = SurveyQuestionViewModel.Input(
            submitTrigger: submitTrigger.eraseToAnyPublisher(),
            dismissAlert: dismissAlertTrigger.eraseToAnyPublisher()
        )
        output = viewModel.transform(input)
        self.input = input
    }

    private func handleSwipe(translation: CGFloat) {
        let didMoveLeft = translation > minDragTranslationForSwipe && tabSelection > 0
        let didMoveRight = translation < -minDragTranslationForSwipe && tabSelection < questions.count - 1

        if didMoveLeft {
            tabSelection -= 1
        } else if didMoveRight {
            tabSelection += 1
        }
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
                                        UserStorage.questionsSubmission = []
                                        isPresented.wrappedValue.toggle()
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
                                    didAction: { tabSelection += 1 }
                                )
                            )
                            .hidden(tabSelection == questions.count - 1)

                        SButtonView(
                            isValid: .constant(true),
                            action: {
                                submitTrigger.send(())
                            },
                            title: "Submit"
                        )
                        .frame(
                            width: 120.0,
                            height: 56.0
                        )
                        .hidden(tabSelection != questions.count - 1)
                    }
                    .padding(.trailing, 20.0)
                }
            }
        }
    }

    private func setUpBackground() -> some View {
        AsyncImage(
            url: questions[tabSelection].largeImageURL
        ) { phase in
            switch phase {
            case .empty:
                ProgressView().hidden()
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure:
                Image(systemName: "person.2.circle")
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            @unknown default:
                EmptyView()
            }
        }
    }
}
