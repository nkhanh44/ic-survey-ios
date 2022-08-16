//
//  BodyTextModifier.swift
//  Survey
//
//  Created by Khanh on 11/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct BodyTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .font(.regularBody)
                .foregroundColor(.white)
                .opacity(0.7)
        }
    }
}
