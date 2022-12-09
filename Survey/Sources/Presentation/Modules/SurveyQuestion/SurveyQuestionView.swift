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
    @State var didShowLottie = false

    var isPresented: Binding<Bool>
    var questions: [SurveyQuestion]
    private let submitTrigger = PassthroughSubject<Void, Never>()
    private let dismissAlertTrigger = PassthroughSubject<Void, Never>()
    private let clearSubmissionTrigger = PassthroughSubject<Void, Never>()
    private let onAppearTrigger = PassthroughSubject<[SurveyQuestion], Never>()
    private let minDragTranslationForSwipe: CGFloat = 30.0

    var body: some View {
        LoadingView(
            isShowing: $output.isLoading,
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
                        .highPriorityGesture(DragGesture())
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
        .fullScreenCover(isPresented: $didShowLottie) {
            ZStack {
                LottieView(lottieFile: "successful")
                    .frame(
                        width: 200.0,
                        height: 200.0
                    )
            }
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
            .background(.black)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withoutAnimation {
                        didShowLottie = false
                        isPresented.wrappedValue.toggle()
                    }
                }
            }
        }
        .onChange(of: output.isSuccess, perform: { isSuccess in
            guard isSuccess else { return }
            withoutAnimation {
                didShowLottie = true
            }
            clearSubmissionTrigger.send()
        })
        .padding(.bottom, 54.0)
        .padding(.top, 54.0)
        .background(
            setUpBackground()
                .opacity(0.6)
        )
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
        .onAppear {
            onAppearTrigger.send(questions)
        }
        .alert(isPresented: .constant($output.alert.wrappedValue != nil)) {
            Alert(
                title: Text(output.alert?.title ?? ""),
                message: Text(output.alert?.message ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    dismissAlertTrigger.send()
                })
            )
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
            dismissAlert: dismissAlertTrigger.eraseToAnyPublisher(),
            clearSubmissionTrigger: clearSubmissionTrigger.eraseToAnyPublisher(),
            onAppearTrigger: onAppearTrigger.eraseToAnyPublisher()
        )
        output = viewModel.transform(input)
        self.input = input
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
                                        clearSubmissionTrigger.send()
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
                            title: AssetLocalization.submissionSubmitText()
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
