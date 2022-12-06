//
//  STextEditorView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct STextEditorView: View {

    let placeholder: String
    let padding: CGFloat = 5.0

    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.primary.opacity(0.25))
                    .padding(
                        EdgeInsets(
                            top: 10.0,
                            leading: 10.0,
                            bottom: 0.0,
                            trailing: 10.0
                        )
                    )
                    .padding(padding)
            }
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(padding)
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITextView.appearance().backgroundColor = nil
        }
    }
}
