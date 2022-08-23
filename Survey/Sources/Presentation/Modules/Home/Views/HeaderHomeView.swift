//
//  HeaderHomeView.swift
//  Survey
//
//  Created by Khanh on 11/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct HeaderHomeView: View {

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(Date().convertToSurveyDateFormat())
                    .font(.smallBoldBody)
                    .foregroundColor(.white)
                    .padding(.bottom, 1.0)

                Text("Today")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}
