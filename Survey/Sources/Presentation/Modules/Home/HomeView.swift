//
//  HomeView.swift
//  SurveyTests
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct HomeView: View {

    @ObservedObject var input: HomeViewModel.Input
    @ObservedObject var output: HomeViewModel.Output

    var body: some View {
        VStack {
            Button("Home", action: {})
                .accessibilityIdentifier(TestConstants.Home.homeButton)
        }
        .preferredColorScheme(.dark)
    }

    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input()
        output = viewModel.transform(input)
        self.input = input
    }
}

struct HomeViewPreView: PreviewProvider {

    static var previews: some View {
        let viewModel = HomeViewModel()
        HomeView(viewModel: viewModel)
    }
}
