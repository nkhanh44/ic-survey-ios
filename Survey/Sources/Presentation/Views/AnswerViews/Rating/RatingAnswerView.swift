//
//  RatingAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct RatingAnswerView: View {

    @ObservedObject var input: AnswerViewModel.Input
    @ObservedObject var output: AnswerViewModel.Output

    @State var displayType: DisplayType
    @State var rating: Int = 0
    @State var icons: [RatingIcon] = []

    var body: some View {
        HStack(alignment: .center, spacing: 0.0) {
            ForEach(Array(icons.enumerated()), id: \.offset) { index, item in
                Text(item.rawValue)
                    .modifier(
                        StarTextModifier(
                            rating: $rating,
                            index: index,
                            selected: false
                        )
                    )
                    .onTapGesture {
                        rating = index
                    }
                    .frame(width: 34.0, height: 28.0)
                    .padding(8.0)
                    .tag(index)
            }
        }
        .onAppear {
            setUpRatingView()
        }
    }

    init(
        viewModel: AnswerViewModel,
        displayType: DisplayType
    ) {
        let input = AnswerViewModel.Input()
        output = viewModel.transform(input)
        self.displayType = displayType
        self.input = input
    }

    private func setUpRatingView() {
        var ratingIcon = RatingIcon.star
        switch displayType {
        case .heart:
            ratingIcon = .heart
        case .smiley:
            ratingIcon = .smiley
        default:
            break
        }
        icons = [RatingIcon](repeating: ratingIcon, count: 5)
    }
}
