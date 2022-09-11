//
//  TextFieldAnswerModifier.swift
//  Survey
//
//  Created by Khanh on 11/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct TextFieldAnswerModifier: ViewModifier {

    var showPlaceHolder: Bool
    var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                setupPlaceholder()
            }
            content
                .textFieldStyle(PaddingTextFieldStyle())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.regularBody)
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(
                        cornerRadius: 12.0,
                        style: .continuous
                    )
                    .fill(.white)
                    .opacity(showPlaceHolder ? 0.2 : 0.3)
                )
                .accentColor(.stoneGray)
                .frame(height: 56.0)
        }
    }

    private func setupPlaceholder() -> some View {
        Text(placeholder)
            .font(.regularBody)
            .padding(.horizontal, 18.0)
            .foregroundColor(.white)
            .opacity(0.3)
    }
}
