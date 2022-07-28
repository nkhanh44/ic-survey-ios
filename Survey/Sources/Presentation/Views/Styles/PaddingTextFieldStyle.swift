//
//  PaddingTextFieldStyle.swift
//  Survey
//
//  Created by Khanh on 28/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

// swiftlint:disable identifier_name

struct PaddingTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .textFieldStyle(.plain)
            .font(.neuzei())
            .padding(3.0)
    }
}
