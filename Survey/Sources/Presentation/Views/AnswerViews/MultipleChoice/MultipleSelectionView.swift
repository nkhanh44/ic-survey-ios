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
    @State var selected = false

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

struct MultipleSelectionViewPreView: PreviewProvider {

    static var previews: some View {
        MultipleSelectionView(title: "Choice 1")
            .background(.black)
    }
}
