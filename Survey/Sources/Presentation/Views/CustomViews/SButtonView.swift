//
//  SButtonView.swift
//  Survey
//
//  Created by Khanh on 27/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SButtonView: View {

    let isValid: Bool = true
    let textColor: Color = .white
    let backgroundColor: Color = .black

    var loginAction: () -> Void

    var title: String

    var body: some View {
        Button(action: {
            loginAction()
        }, label: {
            Text(title)
                .font(.boldBody)
        })
        .frame(maxWidth: .infinity, maxHeight: 56.0)
        .background(isValid ? .white : .stoneGray)
        .foregroundColor(isValid ? .smokeGray : .white)
        .cornerRadius(10.0)
    }
}
