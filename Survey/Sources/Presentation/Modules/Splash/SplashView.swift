//
//  SplashView.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

struct SplashView: View {

    @ObservedObject var input: SplashViewModel.Input
    @ObservedObject var output: SplashViewModel.Output
    @EnvironmentObject private var appRouter: AppRouter
    @State private var fadeInOut = false

    private let willFetchSurveysTrigger = PassthroughSubject<Void, Never>()
    private let loadTrigger = PassthroughSubject<Void, Never>()

    var body: some View {
        LoadingView(
            isShowing: $output.isLoading,
            text: .constant(""),
            content: {
                setUpView()
                    .preferredColorScheme(.dark)
                    .onAppear(perform: {
                        loadTrigger.send()
                    })
                    .onReceive(output.$hasUserLoggedIn.dropFirst()) { hasUserLoggedIn in
                        guard hasUserLoggedIn else {
                            appRouter.state = .login
                            return
                        }
                        willFetchSurveysTrigger.send()
                    }
                    .onReceive(output.$fetchSuccessfully, perform: {
                        guard $0 else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            appRouter.state = .home
                        }
                    })
                    .alert(isPresented: .constant($output.alert.wrappedValue != nil)) {
                        Alert(
                            title: Text(output.alert?.title ?? ""),
                            message: Text(output.alert?.message ?? ""),
                            dismissButton: .default(Text("OK"), action: {
                                if (try? KeychainService.shared.get(key: .token)) == nil {
                                    appRouter.state = .login
                                }
                                $output.alert.wrappedValue = nil
                            })
                        )
                    }
            }
        )
    }

    init(viewModel: SplashViewModel) {
        let input = SplashViewModel.Input(
            loadTrigger: loadTrigger.asDriver(),
            willFetchSurveysTrigger: willFetchSurveysTrigger.asDriver()
        )
        output = viewModel.transform(input)
        self.input = input
    }

    private func setUpView() -> some View {
        ZStack {
            Assets.ic_background.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)

            Assets.ic_logo.image
                .resizable()
                .frame(width: 200.0, height: 48.0, alignment: .center)
                .onAppear(perform: {
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        fadeInOut.toggle()
                    }
                })
                .opacity(fadeInOut ? 1.0 : 0.0)
        }
    }
}

struct SplashViewPreView: PreviewProvider {

    static var previews: some View {
        let viewModel = SplashViewModel(
            userSessionUseCase: UserSessionUseCase(),
            homeUseCase: HomeUseCase(
                surveyRepository: SurveyRepository(
                    api: AuthenticationNetworkAPI()
                )
            )
        )
        return SplashView(viewModel: viewModel)
    }
}
