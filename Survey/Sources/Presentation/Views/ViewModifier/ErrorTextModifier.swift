//
//  ErrorTextModifier.swift
//  Survey
//
//  Created by Khanh on 04/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct ErrorTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .font(.errorBody)
                .foregroundColor(.red)
                .padding()
                .frame(height: 10.0, alignment: .leading)
        }
    }
}
