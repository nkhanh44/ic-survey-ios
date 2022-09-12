//
//  SurveyQuestionBodyView.swift
//  Survey
//
//  Created by Khanh on 23/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct SurveyQuestionBodyView: View {

    var body: some View {
        VStack(alignment: .leading) {
            // TODO: Remove dummy Text
            Text("1/5")
                .modifier(SmallTagTextModifier())
                .padding(.bottom, 10.0)

            // TODO: Remove dummy Text
            Text("How fulfilled did you feel during this WFH period?")
                .modifier(LargerTitleTextModifier())
                .padding(.bottom, 10.0)

            Spacer()
        }
        .padding(.leading, 20.0)
        .padding(.trailing, 20.0)
        .edgesIgnoringSafeArea(.all)
    }
}
