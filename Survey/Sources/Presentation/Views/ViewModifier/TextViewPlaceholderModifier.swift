//
//  TextViewPlaceholderModifier.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct TextViewPlaceholderModifier: ViewModifier {

    var showPlaceholder: Bool
    @State var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceholder {
                TextEditor(text: $placeholder)
                    .font(.regularBody)
                    .padding(.horizontal, 18.0)
                    .foregroundColor(.gray)
                    .opacity(0.3)
            }
            content
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.regularBody)
                .foregroundColor(.black)
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 12.0,
                        style: .continuous
                    )
                    .fill(.white)
                    .opacity(0.17)
                )
                .accentColor(.stoneGray)
        }
    }
}
