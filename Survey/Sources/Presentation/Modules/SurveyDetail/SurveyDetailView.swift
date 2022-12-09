//
//  SurveyDetailView.swift
//  Survey
//
//  Created by Khanh on 16/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct SurveyDetailView: View {

    @ObservedObject var input: SurveyDetailViewModel.Input
    @ObservedObject var output: SurveyDetailViewModel.Output

    @State var fadeInOut = false
    @State var didScaleEffect = false
    @State var surveyQuestions = [SurveyQuestion]()

    private let startSurveyTrigger = PassthroughSubject<String, Never>()
    private let willShowQuestions = PassthroughSubject<Bool, Never>()
    private let dismissAlertTrigger = PassthroughSubject<Void, Never>()
    var isPresented: Binding<Bool>
    let survey: Survey

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LoadingView(
                isShowing: $output.isLoading,
                text: .constant("")
            ) {
                ZStack(alignment: .topLeading) {
                    setUpMainImage()
                    setUpComponents()
                }
            }
        }
        .overlay(content: {
            ZStack(alignment: .bottom) {
                VStack {
                    Spacer()

                    HStack {
                        Spacer()

                        SButtonView(
                            isValid: .constant(true),
                            action: {
                                startSurveyTrigger.send(survey.id)
                            },
                            title: "Start Survey"
                        )
                        .frame(
                            width: 140.0,
                            height: 56.0
                        )
                        .padding(.trailing, 20.0)
                        .padding(.bottom, 54.0)
                        .opacity(fadeInOut ? 1.0 : 0.0)
                    }
                }
            }
        })
        .onReceive(output.$survey) {
            guard let questions = $0?.questions else { return }
            surveyQuestions = questions
            withoutAnimation {
                self.willShowQuestions.send(!surveyQuestions.isEmpty)
            }
        }
        .onAppear(perform: {
            fadeInOut = false
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                fadeInOut.toggle()
            }
        })
        .fullScreenCover(isPresented: $output.isSurveyQuestionPresented) {
            SurveyQuestionView(
                viewModel: SurveyQuestionViewModel(
                    submitSurveyUseCase: SubmitSurveyUseCase(
                        surveyRepository: SurveyRepository(
                            api: AuthenticationNetworkAPI()
                        )
                    ),
                    submissionStorageUseCase: SubmissionStorageUseCase(
                        repository: QuestionSubmissionRepository(
                            storage: QuestionSubmissionStorage.shared
                        )
                    ),
                    id: survey.id
                ),
                isPresented: $output.isSurveyQuestionPresented,
                questions: surveyQuestions
            )
        }
        .transaction { $0.disablesAnimations = true }
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
        .alert(isPresented: .constant($output.alert.wrappedValue != nil)) {
            Alert(
                title: Text(output.alert?.title ?? ""),
                message: Text(output.alert?.message ?? ""),
                dismissButton: .default(Text(AssetLocalization.commonOkText()), action: {
                    dismissAlertTrigger.send()
                })
            )
        }
    }

    init(
        viewModel: SurveyDetailViewModel,
        isPresented: Binding<Bool>,
        survey: Survey
    ) {
        self.survey = survey
        self.isPresented = isPresented
        let input = SurveyDetailViewModel.Input(
            startSurveyTrigger: startSurveyTrigger.asDriver(),
            willShowQuestions: willShowQuestions.asDriver(),
            dismissAlert: dismissAlertTrigger.asDriver()
        )
        output = viewModel.transform(input)
        self.input = input
    }

    private func setUpComponents() -> some View {
        VStack(alignment: .leading) {
            Button {
                withAnimation(Animation.linear(duration: 0.5)) {
                    didScaleEffect.toggle()
                    fadeInOut.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withoutAnimation {
                        isPresented.wrappedValue.toggle()
                    }
                }
            } label: {
                Assets.ic_arrow_back.image
                    .frame(
                        width: 12.0,
                        height: 20.0
                    )
            }
            .padding(.bottom, 30.5)

            Text(survey.title)
                .modifier(LargerTitleTextModifier())
                .padding(.bottom, 16.0)

            Text(survey.description)
                .modifier(BodyTextModifier())

            Spacer(minLength: 120.0)
        }
        .padding(.top, 57.0)
        .padding(.leading, 22.0)
        .padding(.trailing, 22.0)
        .opacity(fadeInOut ? 1.0 : 0.0)
    }

    private func setUpMainImage() -> some View {
        AsyncImage(url: survey.largeImageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.6)
                    .onAppear {
                        didScaleEffect = false
                        withAnimation(Animation.linear(duration: 1.0)) {
                            didScaleEffect.toggle()
                        }
                    }
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
        .scaleEffect(
            x: didScaleEffect ? 1.3 : 1.0,
            y: didScaleEffect ? 1.3 : 1.0,
            anchor: .top
        )
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}
