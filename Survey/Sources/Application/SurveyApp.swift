//
//  SurveyApp.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import IQKeyboardManagerSwift
import SwiftUI

@main
struct SurveyApp: App {

    @StateObject var appRouter = AppRouter()

    @ViewBuilder var rootView: some View {
        switch appRouter.state {
        case .splash:
            SplashView(
                viewModel: SplashViewModel(
                    userSessionUseCase: UserSessionUseCase(),
                    homeUseCase: HomeUseCase(
                        surveyRepository: SurveyRepository(
                            api: AuthenticationNetworkAPI()
                        )
                    )
                )
            )
        case .login:
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
            LoginView(viewModel: viewModel)
        case .home:
            let useCase = HomeUseCase(
                surveyRepository: SurveyRepository(
                    api: AuthenticationNetworkAPI()
                )
            )
            HomeView(
                viewModel: HomeViewModel(
                    useCase: useCase
                )
            )
        }
    }

    var body: some Scene {
        configure()
        return WindowGroup {
            rootView.environmentObject(appRouter)
        }
    }

    private func configure() {
        UIScrollView.appearance().bounces = false

        let IQKeyboard = IQKeyboardManager.shared
        IQKeyboard.enable = true
        IQKeyboard.shouldResignOnTouchOutside = true
    }
}
