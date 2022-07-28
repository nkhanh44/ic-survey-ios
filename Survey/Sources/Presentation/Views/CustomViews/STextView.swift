//
//  STextView.swift
//  Survey
//
//  Created by Khanh on 27/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct STextView: View {

    let textColor: Color = .white
    let style: Font = .neuzei()

    @Binding var text: String

    var body: some View {
        Text(text)
            .font(style)
            .foregroundColor(textColor)
    }
}
