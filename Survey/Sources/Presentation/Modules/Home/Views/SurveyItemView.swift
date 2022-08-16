//
//  SurveyItemView.swift
//  Survey
//
//  Created by Khanh on 10/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyItemView: View {

    @State var isShowing = false
    @State private var fadeInOut = false

    let survey: Survey

    var body: some View {
        ZStack {
            mainImageSetup()
            componentsSetup()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
        }
        .onAppear(perform: {
            fadeInOut = false
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                fadeInOut.toggle()
            }
        })
        .opacity(fadeInOut ? 1.0 : 0.0)
    }

    private func componentsSetup() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(survey.title)
                        .modifier(TitleTextModifier())
                        .lineLimit(4)
                        .padding(.bottom, 16.0)

                    Text(survey.description)
                        .modifier(BodyTextModifier())
                        .lineLimit(2)

                    Spacer(minLength: 0.0)
                }
                .padding(.leading, 20.0)

                Spacer(minLength: 20.0)

                Button("") {}
                    .modifier(CircleButtonModifier())
                    .padding(.trailing, 20.0)
            }
            .frame(height: 126.0)
            .padding(.bottom, 54.0)
        }
    }

    private func mainImageSetup() -> some View {
        // TODO: Remove dummy cover image url
        Image(survey.coverImageURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                ZStack(alignment: .bottom) {
                    // TODO: Remove dummy cover image url
                    Image(survey.coverImageURL)
                        .resizable()
                }
            )
            .opacity(0.6)
            .edgesIgnoringSafeArea(.all)
    }
}
