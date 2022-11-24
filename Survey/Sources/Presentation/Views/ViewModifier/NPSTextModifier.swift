//
//  NPSTextModifier.swift
//  Survey
//
//  Created by Khanh on 17/11/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct NPSTextModifier: ViewModifier {

    @Binding var rating: Int

    @State var index: Int
    @State var selected: Bool

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .font(.boldBody)
                .frame(width: 33.0, height: 56.0)
                .opacity(selected ? 1.0 : 0.5)
                .onChange(of: rating) { newValue in
                    selected = newValue >= index
                }
        }
    }
}
