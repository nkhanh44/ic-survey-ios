//
//  PersonalMenuView.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct PersonalMenuView: View {

    var user: User

    @State var showAlert: Bool = false
    @Binding var showPersonalMenu: Bool
    // TODO: Remove dummy Texts below
    var body: some View {
        HStack {
            setUpLeftView()
            setUpComponents()
                .overlay {
                    setUpVersion()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(AssetLocalization.commonLogoutTitle()),
                        message: Text(""),
                        primaryButton: .destructive(
                            Text(AssetLocalization.commonLogoutText()),
                            action: {
                                // TODO: Replace with logout action in integrate
                                showAlert = false
                            }
                        ),
                        secondaryButton: .default(
                            Text(AssetLocalization.commonCancelText()),
                            action: {
                                showAlert = false
                            }
                        )
                    )
                }
                .padding()
                .frame(width: 240.0, height: UIScreen.main.bounds.height)
                .background(Color.grayScale)
                .opacity(0.9)
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func setUpAvatarButton() -> some View {
        Button(action: {}, label: {
            AsyncImage(
                url: URL(string: user.avatarUrl),
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
            .frame(width: 36.0, height: 36.0)
        })
        .padding()
    }

    private func setUpComponents() -> some View {
        VStack {
            HStack {
                Text(user.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
                setUpAvatarButton()
            }
            .padding(.top, 10.0)
            Divider()
                .background(.white)
            HStack {
                Button(AssetLocalization.userLogoutButtonText()) {
                    showAlert.toggle()
                }
                .font(.regularBody)
                .foregroundColor(.white)
                .opacity(0.5)
                Spacer()
            }
            .padding(.top, 20.0)

            Spacer()
        }
    }

    private func setUpLeftView() -> some View {
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
    }

    private func setUpVersion() -> some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text(Bundle.main.releaseVersionNumber)
                    .font(.smallBody)
                    .foregroundColor(.white)
                    .opacity(0.5)
                Spacer()
            }
            .padding()
        }
    }
}

struct PersonalMenuViewPreview: PreviewProvider {

    static var previews: some View {
        PersonalMenuView(
            user: APIUser.dummy,
            showPersonalMenu: .constant(true)
        )
    }
}
