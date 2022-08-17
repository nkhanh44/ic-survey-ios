//
//  LargerTitleTextModifier.swift
//  Survey
//
//  Created by Khanh on 17/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct LargerTitleTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .font(.largeTitle)
                .foregroundColor(.white)
                .lineSpacing(5.0)
        }
    }
}
