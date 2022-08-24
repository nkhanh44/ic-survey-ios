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

    // TODO: Remove dummy survey and list
    let survey = APISurvey.dummyList[0]
    let list = Array(APISurvey.dummyList.enumerated())

    var body: some View {
        LoadingView(
            isShowing: .constant(false),
            text: .constant(""),
            content: {
                ZStack {
                    TabView {
                        ForEach(list, id: \.element.id) { _ in
                            SurveyQuestionBodyView()
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
                .overlay {
                    closeButtonSetup()
                    nextQuestionButtonSetup()
                }
            }
        )
        .padding(.bottom, 54.0)
        .padding(.top, 54.0)
        .background(
            // TODO: Remove dummy cover image url
            Image(survey.coverImageURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.6)
        )
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }

    private func closeButtonSetup() -> some View {
        ZStack(alignment: .top) {
            VStack {
                HStack {
                    Spacer()

                    Button("") {}
                        .modifier(
                            CloseButtonModifier(
                                didAction: {}
                            )
                        )
                        .padding(.trailing, 20.0)
                }

                Spacer()
            }
        }
    }

    private func nextQuestionButtonSetup() -> some View {
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

struct SurveyQuestionViewPreView: PreviewProvider {

    static var previews: some View {
        SurveyQuestionView()
    }
}
