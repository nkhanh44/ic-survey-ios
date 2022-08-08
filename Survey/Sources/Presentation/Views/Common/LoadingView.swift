//
//  LoadingView.swift
//  Survey
//
//  Created by Khanh on 02/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {

    @Binding var isShowing: Bool
    @Binding var text: String
    var content: (GeometryProxy) -> Content

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .center) {
                self.content(geo)
                    .disabled(self.isShowing)

                VStack {
                    if !self.text.isEmpty {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                            .padding(.top)
                        Text(self.text)
                            .padding([.leading, .trailing, .bottom])
                    } else {
                        ActivityIndicator(isAnimating: .constant(true), style: .large)
                    }
                }
                .frame(minWidth: 68.0,
                       minHeight: 68.0,
                       alignment: .center)
                .background(Color.smokeGray)
                .cornerRadius(6.0)
                .opacity(self.isShowing ? 1.0 : 0.0)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .preferredColorScheme(.dark)
    }
}
