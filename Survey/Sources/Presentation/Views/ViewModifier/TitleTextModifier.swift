//
//  TitleTextModifier.swift
//  Survey
//
//  Created by Khanh on 11/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct TitleTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .font(.boldTitle)
                .foregroundColor(.white)
                .lineSpacing(5.0)
        }
    }
}
