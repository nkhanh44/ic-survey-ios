//
//  CloseButtonModifier.swift
//  Survey
//
//  Created by Khanh on 23/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct CloseButtonModifier: ViewModifier {

    var didAction: () -> Void

    func body(content: Content) -> some View {
        ZStack {
            Button {
                didAction()
            } label: {
                Assets.ic_close.image
                    .frame(
                        width: 28.0,
                        height: 28.0
                    )
                    .clipShape(Circle())
            }
        }
    }
}
