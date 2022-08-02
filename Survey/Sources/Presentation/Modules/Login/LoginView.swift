//
//  LoginView.swift
//  Survey
//
//  Created by Khanh on 27/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct LoginView: View {

    @ObservedObject var input: LoginViewModel.Input
    @ObservedObject var output: LoginViewModel.Output

    private let logInTrigger = PassthroughSubject<Void, Never>()

    @State private var email = ""
    @State private var password = ""

    private var loginTitle = "Login"

    private let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0.0),
            .init(color: .black.opacity(0.2), location: 1.0)
        ]),
        startPoint: .bottom,
        endPoint: .top
    )

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundSetup()
                VStack(spacing: 0.0) {
                    logoSetup()
                        .frame(height: geo.size.height * (1.0 / 3.0))
                        .offset(y: 20.0)
                    componentSetup()
                        .frame(height: geo.size.height * (1.0 / 3.0))
                    Spacer()
                        .frame(height: geo.size.height * (1.0 / 3.0))
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }

    init(viewModel: LoginViewModel) {
        let input = LoginViewModel.Input(logInTrigger: logInTrigger.asDriver())
        output = viewModel.transform(input)
        self.input = input
    }

    private func backgroundSetup() -> some View {
        Assets.ic_background.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                ZStack(alignment: .bottom) {
                    Assets.ic_background.image
                        .resizable()
                        .blur(radius: 15.0, opaque: true)
                        .clipped()
                    gradient
                }
            )
            .edgesIgnoringSafeArea(.all)
    }

    private func componentSetup() -> some View {
        VStack(alignment: .center, spacing: 0.0) {
            TextField("", text: $email)
                .modifier(PlaceholderModifier(showPlaceHolder: email.isEmpty, placeholder: "Email"))
                .padding(.bottom, 20.0)

            SecureField("", text: $password)
                .modifier(PlaceholderModifier(showPlaceHolder: password.isEmpty, placeholder: "Password"))
                .padding(.bottom, 20.0)

            SButtonView(loginAction: {
                logInTrigger.send(())
            }, title: loginTitle)
        }
        .padding([.leading, .trailing], 24.0)
    }

    private func logoSetup() -> some View {
        VStack {
            Assets.ic_logo.image
                .resizable()
                .frame(width: 167.84, height: 40.0)
        }
    }
}

struct LoginViewPreView: PreviewProvider {

    static var previews: some View {
        let useCase = LogInUseCase(loginRepository: LogInRepository(api: NetworkAPI(decoder: .japxDecoder)))
        let viewModel = LoginViewModel(useCase: useCase)
        return LoginView(viewModel: viewModel)
    }
}
