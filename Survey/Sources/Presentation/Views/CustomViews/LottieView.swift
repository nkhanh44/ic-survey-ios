//
//  LottieView.swift
//  Survey
//
//  Created by Khanh on 06/12/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {

    let lottieFile: String

    let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)

        animationView.animation = Animation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()

        view.addSubview(animationView)

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
