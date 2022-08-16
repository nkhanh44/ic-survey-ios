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

    private var input: SplashViewModel.Input
    @ObservedObject var output: SplashViewModel.Output

    @EnvironmentObject private var appRouter: AppRouter

    @State private var fadeInOut = false

    var body: some View {
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
        .preferredColorScheme(.dark)
        .onReceive(output.$hasUserLoggedIn) { hasUserLoggedIn in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                appRouter.state = hasUserLoggedIn ? .home : .login
            }
        }
    }

    init(viewModel: SplashViewModel) {
        let input = SplashViewModel.Input(loadTrigger: Driver.just(()))
        output = viewModel.transform(input)
        self.input = input
    }
}

struct SplashViewPreView: PreviewProvider {

    static var previews: some View {
        let viewModel = SplashViewModel(useCase: UserSessionUseCase())
        return SplashView(viewModel: viewModel)
    }
}
