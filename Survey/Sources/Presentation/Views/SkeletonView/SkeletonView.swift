//
//  SkeletonView.swift
//  Survey
//
//  Created by Khanh on 15/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import ShimmerView
import SwiftUI

struct SkeletonView: View {

    @Binding var isAnimating: Bool

    private let style = ShimmerViewStyle(
        baseColor: .white.withAlphaComponent(0.12),
        highlightColor: .white.withAlphaComponent(0.3),
        duration: 1.2,
        interval: 0.4,
        effectSpan: .points(120.0),
        effectAngle: 0.0 * CGFloat.pi
    )

    var body: some View {
        ShimmerScope(style: style, isAnimating: $isAnimating) {
            VStack(alignment: .leading) {
                setUpHeaderComponents()

                Spacer()

                ShimmerElement(width: 50.0, height: 20.0)
                    .cornerRadius(14.0)
                ShimmerElement(width: 250.0, height: 20.0)
                    .cornerRadius(14.0)
                ShimmerElement(width: 117.0, height: 20.0)
                    .cornerRadius(14.0)
                    .padding(.bottom, 16.0)
                ShimmerElement(width: 300.0, height: 20.0)
                    .cornerRadius(14.0)
                ShimmerElement(width: 200.0, height: 20.0)
                    .cornerRadius(14.0)
            }
        }
        .background(.black)
    }

    private func setUpHeaderComponents() -> some View {
        HStack {
            VStack(alignment: .leading) {
                ShimmerElement(width: 117.0, height: 20.0)
                    .foregroundColor(.black)
                    .cornerRadius(14.0)
                ShimmerElement(width: 100.0, height: 20.0)
                    .cornerRadius(14.0)
            }
            Spacer()
            ShimmerElement(width: 36.0, height: 36.0)
                .cornerRadius(18.0)
        }
    }
}

struct SkeletonViewPreView: PreviewProvider {

    static var previews: some View {
        SkeletonView(isAnimating: .constant(true))
    }
}
