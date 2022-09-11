//
//  TextFieldAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct TextFieldAnswerView: View {

    var isMultipleLines = false
    @State var textFieldAnswers: [String]
    @State var text: String = ""

    var answerPlaceholders: [String]
    let placeholderText: String

    var body: some View {
        VStack {
            if isMultipleLines {
                STextEditorView(placeholder: placeholderText, text: $text)
                    .font(.body)
                    .background(.gray.opacity(0.2))
                    .accentColor(.stoneGray)
                    .frame(height: 168.0)
                    .cornerRadius(10.0)
            } else {
                ForEach(textFieldAnswers.indices, id: \.self) { index in
                    TextField("", text: $textFieldAnswers[index].projectedValue)
                        .modifier(
                            TextFieldAnswerModifier(
                                showPlaceHolder: textFieldAnswers[index].isEmpty,
                                placeholder: answerPlaceholders[index]
                            )
                        )
                        .padding(.bottom, 16.0)
                }
            }
        }
        .padding()
    }
}

struct TextFieldAnswerViewPreView: PreviewProvider {

    static var previews: some View {
        TextFieldAnswerView(
            textFieldAnswers: ["", "", ""],
            answerPlaceholders: [
                "placeholder 1",
                "placeholder 2",
                "placeholder 3"
            ],
            placeholderText: "Your thoughts"
        )
        .background(.blue)
    }
}
