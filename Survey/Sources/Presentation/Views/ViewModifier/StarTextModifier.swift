//
//  StarTextModifier.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct StarTextModifier: ViewModifier {

    @Binding var rating: Int

    @State var index: Int
    @State var selected: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .frame(width: 24.0, height: 24.0)
                .opacity(selected ? 1.0 : 0.5)
                .onChange(of: rating) { newValue in
                    selected = newValue >= index
                }
        }
    }
}
