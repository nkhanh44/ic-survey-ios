//
//  SSecureFieldView.swift
//  Survey
//
//  Created by Khanh on 28/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SSecureFieldView: View {

    @Binding var field: String

    var body: some View {
        SecureField("", text: $field)
            .textFieldStyle(PaddingTextFieldStyle())
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .font(.neuzei())
            .foregroundColor(.white)
            .padding()
            .background(RoundedRectangle(cornerRadius: 12.0, style: .continuous).fill(.white).opacity(0.17))
            .accentColor(.stoneGray)
    }
}
