//
//  PersonalMenuView.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct PersonalMenuView: View {

    @State var imageURL: String
    @State var showAlert: Bool = false
    @Binding var showPersonalMenu: Bool
    // TODO: Remove dummy Texts below
    var body: some View {
        HStack {
            ZStack {
                Color.black.opacity(0.0)
                Rectangle()
                    .frame(
                        width: UIScreen.main.bounds.width - 240.0,
                        height: UIScreen.main.bounds.height
                    )
                    .blendMode(.destinationOut)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            showPersonalMenu = false
                        }
                    }
            }
            .compositingGroup()

            VStack {
                HStack {
                    Text("Mai")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Spacer()
                    setUpAvatarButton()
                }
                .padding(.top, 10.0)
                Divider()
                    .background(.white)
                HStack {
                    Button("Logout") {
                        showAlert.toggle()
                    }
                    .font(.regularBody)
                    .foregroundColor(.white)
                    .opacity(0.5)
                    Spacer()
                }
                .padding(.top, 30.0)

                Spacer()
            }
            .overlay {
                VStack(alignment: .leading) {
                    Spacer()
                    HStack {
                        Text("v0.1.0 (1562903885)")
                            .font(.smallBody)
                            .foregroundColor(.white)
                            .opacity(0.5)
                        Spacer()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are you sure you want to log out?"),
                    message: Text(""),
                    primaryButton: .destructive(Text("Log out"), action: {
                        showAlert = false
                    }),
                    secondaryButton: .default(Text("Cancel"), action: {
                        showAlert = false
                    })
                )
            }
            .padding()
            .frame(width: 240.0, height: UIScreen.main.bounds.height)
            .background(Color.grayScale)
            .opacity(0.9)
        }
    }

    private func setUpAvatarButton() -> some View {
        Button(action: {}, label: {
            AsyncImage(
                url: URL(string: imageURL),
                transaction: Transaction(animation: .easeIn(duration: 1.0))
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
        .padding()
    }
}

struct PersonalMenuViewPreview: PreviewProvider {

    static var previews: some View {
        PersonalMenuView(
            imageURL: "https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d",
            showPersonalMenu: .constant(true)
        )
    }
}
