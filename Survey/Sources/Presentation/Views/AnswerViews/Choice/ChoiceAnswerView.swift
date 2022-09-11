//
//  ChoiceAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct ChoiceAnswerView: View {

    var answerTexts: [String] = []

    var body: some View {
        ZStack {
            PickerView(selections: .constant([1]), data: [answerTexts])
                .background(.clear)
                .overlay {
                    Spacer()
                        .frame(height: 56.0)
                        .padding(.horizontal, 30)
                        .overlay(Divider().background(.white), alignment: .top)
                        .overlay(Divider().background(.white), alignment: .bottom)
                }
        }
    }
}

struct ChoiceAnswerViewPreView: PreviewProvider {

    static var previews: some View {
        ChoiceAnswerView(
            answerTexts: [
                "Very fulfilled",
                "Somewhat fullfilled",
                "Somewhat unfulfilled"
            ]
        )
        .background(.black)
    }
}
