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

    private let loadTrigger = PassthroughSubject<Void, Never>()

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
    }

    init(viewModel: SplashViewModel) {
        let input = SplashViewModel.Input(loadTrigger: loadTrigger.asDriver())
        output = viewModel.transform(input)
        self.input = input
    }
}

struct SplashViewPreView: PreviewProvider {

    static var previews: some View {
        let viewModel = SplashViewModel()
        return SplashView(viewModel: viewModel)
    }
}
