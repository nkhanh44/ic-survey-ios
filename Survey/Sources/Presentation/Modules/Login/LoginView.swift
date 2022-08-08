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
        LoadingView(isShowing: $output.isLoading, text: .constant("")) { geo in
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
        VStack(alignment: .leading, spacing: 0.0) {
            emailSetup()
            passwordSetup()
            SButtonView(
                isValid: $output.isLoginEnabled,
                loginAction: { logInTrigger.send(()) },
                title: loginTitle
            )
        }
        .padding([.leading, .trailing], 24.0)
    }

    private func emailSetup() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            TextField("", text: $input.email)
                .modifier(PlaceholderModifier(showPlaceHolder: input.email.isEmpty, placeholder: "Email"))
                .padding(.bottom, 3.0)

            Text(SError.invalidEmail.detail)
                .modifier(ErrorTextModifier())
                .padding(.bottom, 7.0)
                .hidden(output.isEmailValid)
        }
    }

    private func passwordSetup() -> some View {
        VStack(alignment: .leading, spacing: 0.0) {
            SecureField("", text: $input.password)
                .modifier(PlaceholderModifier(showPlaceHolder: input.password.isEmpty, placeholder: "Password"))
                .padding(.bottom, 3.0)

            Text(SError.invalidPassword.detail)
                .modifier(ErrorTextModifier())
                .padding(.bottom, 7.0)
                .hidden(output.isPasswordValid)
        }
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
        let loginUseCase = LogInUseCase(loginRepository: LogInRepository(api: NetworkAPI(decoder: .japxDecoder)))
        let storeTokenUseCase = StoreTokenUseCase()
        let viewModel = LoginViewModel(loginUseCase: loginUseCase, storeUseCase: storeTokenUseCase)
        return LoginView(viewModel: viewModel)
    }
}
