//
//  RatingAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct RatingAnswerView: View {

    @State var rating: Int
    @State var icons: [RatingIcon]

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
        .background(.clear)
    }
}

struct RatingAnswerViewPreView: PreviewProvider {

    static var previews: some View {
        RatingAnswerView(rating: 0, icons: [])
    }
}
