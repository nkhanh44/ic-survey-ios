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
                    .font(.neuzei())
                    .padding(.horizontal, 18.0)
                    .foregroundColor(.white)
                    .opacity(0.3)
            }
            content
        }
    }
}
