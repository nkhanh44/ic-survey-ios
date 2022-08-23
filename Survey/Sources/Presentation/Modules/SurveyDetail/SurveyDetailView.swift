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
    @State var isSurveyQuestionPresented = false

    private let startSurveyTrigger = PassthroughSubject<Void, Never>()
    var isPresented: Binding<Bool>
    let survey: Survey

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .topLeading) {
                mainImageSetup()
                componentsSetup()
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
                                startSurveyTrigger.send()
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
        .onAppear(perform: {
            fadeInOut = false
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                fadeInOut.toggle()
            }

            didScaleEffect = false
            withAnimation(Animation.linear(duration: 0.5)) {
                didScaleEffect.toggle()
            }
        })
        .onReceive(output.$willGoToNextSurvey) {
            guard $0 else { return }
            withoutAnimation {
                isSurveyQuestionPresented.toggle()
            }
        }
        .fullScreenCover(isPresented: $isSurveyQuestionPresented) {
            EmptyView()
        }
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }

    init(
        viewModel: SurveyDetailViewModel,
        isPresented: Binding<Bool>,
        survey: Survey
    ) {
        self.survey = survey
        self.isPresented = isPresented
        let input = SurveyDetailViewModel.Input(
            startSurveyTrigger: startSurveyTrigger.asDriver()
        )
        output = viewModel.transform(input)
        self.input = input
    }

    private func componentsSetup() -> some View {
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

    private func mainImageSetup() -> some View {
        // TODO: Remove dummy cover image url
        Image(survey.coverImageURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(
                x: didScaleEffect ? 1.3 : 1.0,
                y: didScaleEffect ? 1.3 : 1.0,
                anchor: .trailing
            )
            .edgesIgnoringSafeArea(.all)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height
            )
            .opacity(0.6)
    }
}
