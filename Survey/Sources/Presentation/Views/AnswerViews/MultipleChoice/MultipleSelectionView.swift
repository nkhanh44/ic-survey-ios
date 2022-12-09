//
//  MultipleSelectionView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct MultipleSelectionView: View {

    var title: String
    @Binding var selected: Bool

    var body: some View {
        HStack {
            Text(title)
                .opacity(selected ? 1.0 : 0.5)
                .font(.mediumBold)
                .foregroundColor(.white)

            Spacer()

            Button("") {}
                .modifier(
                    CheckButtonModifier(
                        selected: $selected,
                        didAction: {}
                    )
                )
        }
    }
}
