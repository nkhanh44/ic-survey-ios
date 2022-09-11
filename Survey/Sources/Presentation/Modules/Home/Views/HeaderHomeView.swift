//
//  HeaderHomeView.swift
//  Survey
//
//  Created by Khanh on 11/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct HeaderHomeView: View {

    @State var imageURL: String
    @Binding var isShowingPersonalMenu: Bool

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Date().convertToSurveyDateFormat())
                    .font(.smallBoldBody)
                    .foregroundColor(.white)
                    .padding(.bottom, 1.0)

                Text("Today")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            Spacer()
            setUpAvatarButton()
        }
    }

    private func setUpAvatarButton() -> some View {
        Button(action: {
            withAnimation(.easeIn) {
                isShowingPersonalMenu.toggle()
            }
        }, label: {
            AsyncImage(
                url: URL(string: imageURL)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView().hidden()
                case let .success(image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "person.2.circle")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                @unknown default:
                    EmptyView()
                }
            }
            .frame(
                width: 36.0,
                height: 36.0
            )
        })
        .hidden(withAnimation(.easeIn) { isShowingPersonalMenu })
        .padding()
    }
}
