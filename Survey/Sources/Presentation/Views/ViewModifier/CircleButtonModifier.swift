//
//  CircleButtonModifier.swift
//  Survey
//
//  Created by Khanh on 11/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct CircleButtonModifier: ViewModifier {

    var didAction: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            Button {
                didAction()
            } label: {
                Assets.ic_next.image
                    .frame(
                        width: 56.0,
                        height: 56.0
                    )
                    .background(.white)
                    .clipShape(Circle())
            }
        }
    }
}
