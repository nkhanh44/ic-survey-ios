//
//  SmallTagTextModifier.swift
//  Survey
//
//  Created by Khanh on 23/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SmallTagTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .font(.smallBoldTag)
                .foregroundColor(.white)
                .opacity(0.5)
        }
    }
}
