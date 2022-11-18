//
//  NPSAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct NPSAnswerView: View {

    @ObservedObject var input: AnswerViewModel.Input
    @ObservedObject var output: AnswerViewModel.Output

    @State var rating: Int = -1

    var body: some View {
        VStack {
            setUpComponents()
                .overlay(
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(.white, lineWidth: 0.5)
                        .frame(height: 56.0)
                )
                .frame(height: 56.0)
                .background(.clear)

            setUpDescription()
        }
    }

    init(viewModel: AnswerViewModel) {
        let input = AnswerViewModel.Input()
        output = viewModel.transform(input)
        self.input = input
    }
}

extension NPSAnswerView {

    private func setUpComponents() -> some View {
        HStack(alignment: .center, spacing: 0.0) {
            let pointList = Array(1 ... 10)
            ForEach(Array(pointList.enumerated()), id: \.offset) { index, point in
                ZStack {
                    Text("\(point)")
                        .modifier(
                            NPSTextModifier(
                                rating: $rating,
                                index: index,
                                selected: false
                            )
                        )
                        .onTapGesture {
                            rating = index
                        }
                        .foregroundColor(.white)
                        .tag(index)
                    if point != 10 {
                        Divider()
                            .background(.white)
                            .frame(
                                width: 33.0,
                                height: 56.0,
                                alignment: .trailing
                            )
                    }
                }
            }
        }
    }

    private func setUpDescription() -> some View {
        HStack {
            Text(AssetLocalization.npsNotLikelyText())
                .opacity((rating < 5) && (rating >= 0) ? 1.0 : 0.5)
                .foregroundColor(.white)
                .font(.boldBody)
            Spacer()
            Text(AssetLocalization.npsLikelyText())
                .opacity(rating >= 5 ? 1.0 : 0.5)
                .foregroundColor(.white)
                .font(.boldBody)
        }
        .frame(width: 330.0)
    }
}
