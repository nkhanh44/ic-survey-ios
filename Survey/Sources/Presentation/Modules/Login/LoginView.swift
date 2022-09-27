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

    @EnvironmentObject private var appRouter: AppRouter

    private let logInTrigger = PassthroughSubject<Void, Never>()
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
        LoadingView(isShowing: $output.isLoading, text: .constant("")) {
            GeometryReader { geo in
                ZStack {
                    setupBackground()
                    VStack(spacing: 0.0) {
                        setUpLogo()
                            .frame(height: geo.size.height * (1.0 / 3.0))
                            .offset(y: 20.0)
                        setUpComponent()
                            .frame(height: geo.size.height * (1.0 / 3.0))
                        Spacer()
                            .frame(height: geo.size.height * (1.0 / 3.0))
                    }
                }
            }
        }
        .alert(isPresented: .constant($output.alert.wrappedValue != nil)) {
            Alert(
                title: Text(output.alert?.title ?? ""),
                message: Text(output.alert?.message ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    $output.alert.wrappedValue = nil
                })
            )
        }
        .onReceive(output.$isLoggedInSuccessfully) {
            if $0 {
                appRouter.state = .home
            }
        }
    }

    init(viewModel: LoginViewModel) {
        let input = LoginViewModel.Input(logInTrigger: logInTrigger.asDriver())
        output = viewModel.transform(input)
        self.input = input
    }

    private func setupBackground() -> some View {
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

    private func setUpComponent() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            setUpEmail()
            setUpPassword()
            SButtonView(
                isValid: $output.isLoginEnabled,
                action: { logInTrigger.send(()) },
                title: loginTitle
            )
            .accessibilityIdentifier(TestConstants.Login.loginButton)
        }
        .padding([.leading, .trailing], 24.0)
    }

    private func setUpEmail() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            TextField("", text: $input.email)
                .modifier(PlaceholderModifier(showPlaceholder: input.email.isEmpty, placeholder: "Email"))
                .padding(.bottom, 3.0)
                .accessibilityIdentifier(TestConstants.Login.emailInputTextField)

            Text(SError.invalidEmail.detail)
                .modifier(ErrorTextModifier())
                .padding(.bottom, 7.0)
                .hidden(output.isEmailValid)
        }
    }

    private func setUpPassword() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            SecureField("", text: $input.password)
                .modifier(PlaceholderModifier(showPlaceholder: input.password.isEmpty, placeholder: "Password"))
                .padding(.bottom, 3.0)
                .accessibilityIdentifier(TestConstants.Login.passwordInputTextField)

            Text(SError.invalidPassword.detail)
                .modifier(ErrorTextModifier())
                .padding(.bottom, 7.0)
                .hidden(output.isPasswordValid)
        }
    }

    private func setUpLogo() -> some View {
        VStack {
            Assets.ic_logo.image
                .resizable()
                .frame(width: 167.84, height: 40.0)
        }
    }
}

struct LoginViewPreView: PreviewProvider {

    static var previews: some View {
        let loginUseCase = LogInUseCase(
            loginRepository: LogInRepository(
                api: NetworkAPI(decoder: .japxDecoder)
            )
        )
        let storeTokenUseCase = StoreTokenUseCase()
        let viewModel = LoginViewModel(
            loginUseCase: loginUseCase,
            storeUseCase: storeTokenUseCase
        )
        return LoginView(viewModel: viewModel)
    }
}
