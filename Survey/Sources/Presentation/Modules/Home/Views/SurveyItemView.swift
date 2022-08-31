//
//  SurveyItemView.swift
//  Survey
//
//  Created by Khanh on 10/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyItemView: View {

    @State private var fadeInOut = false

    let survey: Survey
    let willGoToDetail: () -> Void

    var body: some View {
        ZStack {
            mainImageSetup()
                .overlay {
                    componentsSetup()
                        .frame(
                            width: UIScreen.main.bounds.width,
                            height: UIScreen.main.bounds.height
                        )
                        .opacity(fadeInOut ? 1.0 : 0.0)
                }
        }
        .onAppear(perform: {
            fadeInOut = false
            withAnimation(Animation.easeInOut(duration: 1.0)) {
                fadeInOut.toggle()
            }
        })
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
                    .modifier(
                        CircleButtonModifier(
                            didAction: { willGoToDetail() }
                        )
                    )
                    .padding(.trailing, 20.0)
            }
            .frame(height: 126.0)
            .padding(.bottom, 54.0)
        }
    }

    private func mainImageSetup() -> some View {
        AsyncImage(
            url: survey.largeImageURL,
            transaction: Transaction(animation: .easeInOut(duration: 1.0))
        ) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .hidden()
            case let .success(image):
                image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .onAppear(perform: {
                        fadeInOut = true
                    })
            case .failure:
                Assets.ic_background.image
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            @unknown default:
                EmptyView()
            }
        }
        .opacity(fadeInOut ? 0.6 : 0.0)
        .frame(
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
    }
}
