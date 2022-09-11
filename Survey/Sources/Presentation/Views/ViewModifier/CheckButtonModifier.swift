//
//  CheckButtonModifier.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct CheckButtonModifier: ViewModifier {

    @Binding var selected: Bool

    var didAction: () -> Void
    var image: Image {
        selected ? Assets.ic_checked.image : Assets.ic_unchecked.image
    }

    func body(content: Content) -> some View {
        ZStack {
            Button {
                selected.toggle()
                didAction()
            } label: {
                image
                    .frame(
                        width: 24.0,
                        height: 24.0
                    )
                    .background(.clear)
                    .clipShape(Circle())
            }
        }
    }
}
