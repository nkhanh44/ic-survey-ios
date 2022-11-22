//
//  NPSAnswerView.swift
//  Survey
//
//  Created by Khanh on 10/09/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import SwiftUI

struct NPSAnswerView: View {

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

    private func setUpComponents() -> some View {
        HStack(alignment: .center, spacing: 0.0) {
            let pointList = Array(1 ... 10)
            ForEach(pointList, id: \.self) { point in
                ZStack {
                    Text("\(point)")
                        .font(.boldBody)
                        .frame(width: 33.0, height: 56.0)
                        .foregroundColor(.white)
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
            Text("Not at all Likely")
                .foregroundColor(.white)
                .font(.boldBody)
            Spacer()
            Text("Extremely Likely")
                .foregroundColor(.white)
                .font(.boldBody)
        }
        .frame(width: 330.0)
    }
    
}

struct NPSAnswerViewPreView: PreviewProvider {

    static var previews: some View {
        Group {
            NPSAnswerView()
                .background(.black)
        }
    }
}
