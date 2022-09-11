//
//  MultipleChoiceAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct MultipleChoiceAnswerView: View {

    var choices: [String]

    var body: some View {
        VStack(alignment: .center, spacing: 0.0) {
            ForEach(choices, id: \.self) { item in
                MultipleSelectionView(title: item)
                    .padding()

                if item != choices.last {
                    Divider()
                        .background(.white)
                }
            }
        }
        .background(.clear)
    }
}

struct MultipleChoiceAnswerViewPreView: PreviewProvider {

    static var previews: some View {
        MultipleChoiceAnswerView(
            choices: [
                "Choice 1",
                "Choice 2",
                "Choice 3"
            ]
        )
        .background(.black)
    }
}
