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

    private let cancelBag = CancelBag()
    private let loadTrigger = PassthroughSubject<Void, Never>()

    @State private var image: UIImage? = UIImage(named: "ic_background")
    @State private var fadeInOut = false

    var body: some View {
        ZStack {
            Image("ic_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.top)

            Image("ic_logo")
                .resizable()
                .frame(width: 200, height: 48, alignment: .center)
                .onAppear(perform: {
                    withAnimation(Animation.easeInOut(duration: 1).delay(2)) {
                        fadeInOut.toggle()
                    }
                })
                .opacity(fadeInOut ? 1 : 0)
        }
    }

    init(viewModel: SplashViewModel) {
        let input = SplashViewModel.Input(loadTrigger: loadTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct SplashViewPreView: PreviewProvider {

    static var previews: some View {
        let viewModel = SplashViewModel()
        return SplashView(viewModel: viewModel)
    }
}
