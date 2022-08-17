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

    // TODO: Remove dummy survey
    private let survey = APISurvey.dummyList.first

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .topLeading) {
                mainImageSetup()

                VStack(alignment: .leading) {
                    Button {} label: {
                        Assets.ic_arrow_back.image
                            .frame(
                                width: 12.0,
                                height: 20.0
                            )
                    }
                    .padding(.bottom, 30.5)

                    Text(survey?.title ?? "")
                        .modifier(LargerTitleTextModifier())
                        .padding(.bottom, 16.0)

                    Text(survey?.description ?? "")
                        .modifier(BodyTextModifier())

                    Spacer(minLength: 120.0)
                }
                .padding(.top, 57.0)
                .padding(.leading, 22.0)
                .padding(.trailing, 22.0)
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
                            action: {},
                            title: "Start Survey"
                        )
                        .frame(
                            width: 140.0,
                            height: 56.0
                        )
                        .padding(.trailing, 20.0)
                        .padding(.bottom, 54.0)
                    }
                }
            }
        })
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }

    private func mainImageSetup() -> some View {
        // TODO: Remove dummy cover image url
        Image(survey?.coverImageURL ?? "")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .scaleEffect(x: 1.3, y: 1.3, anchor: .trailing)
            .opacity(0.6)
            .edgesIgnoringSafeArea(.all)
    }
}

struct SurveyDetailViewPreView: PreviewProvider {

    static var previews: some View {
        SurveyDetailView()
    }
}
