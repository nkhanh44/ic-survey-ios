//
//  PlaceholderModifier.swift
//  Survey
//
//  Created by Khanh on 28/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct PlaceholderModifier: ViewModifier {

    var showPlaceHolder: Bool
    var placeholder: String

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .font(.regularBody)
                    .padding(.horizontal, 18.0)
                    .foregroundColor(.white)
                    .opacity(0.3)
            }
            content
                .textFieldStyle(PaddingTextFieldStyle())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.regularBody)
                .foregroundColor(.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12.0, style: .continuous).fill(.white).opacity(0.17))
                .accentColor(.stoneGray)
                .frame(height: 56.0)
        }
    }
}
