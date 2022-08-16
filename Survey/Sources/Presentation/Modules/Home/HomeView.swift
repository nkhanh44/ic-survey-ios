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
    @State var currentPage = 0
    @State var tabSelection = 0

    private let minDragTranslationForSwipe: CGFloat = 60.0
    // TODO: Remove dummy list of API Survey
    private let list = Array(APISurvey.dummyList.enumerated())

    var body: some View {
        LoadingView(
            isShowing: .constant(false),
            text: .constant(""),
            content: {
                ZStack {
                    tabViewSetup()
                        .overlay(alignment: .top) {
                            HeaderHomeView()
                                .padding(.top, 60.0)
                                .padding(.leading, 20.0)
                        }
                }
            }
        )
        .preferredColorScheme(.dark)
    }

    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input()
        output = viewModel.transform(input)
        self.input = input
    }

    private func tabViewSetup() -> some View {
        TabView(selection: $tabSelection) {
            ForEach(list, id: \.element.id) { args in
                let (index, survey) = args
                SurveyItemView(survey: survey)
                    .tag(index)
                    .onAppear {
                        currentPage = index
                    }
            }
            .highPriorityGesture(DragGesture().onEnded {
                handleSwipe(translation: $0.translation.width)
            })
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(alignment: .leading) {
            VStack(alignment: .leading) {
                Spacer()
                PageControlView(
                    currentPage: $currentPage,
                    numberOfPages: list.count,
                    didSelect: { index in
                        tabSelection = index
                    }
                )
                .frame(
                    width: .zero,
                    height: 8.0,
                    alignment: .leading
                )
                .accessibilityIdentifier(TestConstants.Home.pageIndicator)
                .padding(.bottom, 200.0)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func handleSwipe(translation: CGFloat) {
        let listCount = list.count
        let didMoveLeft = translation > minDragTranslationForSwipe && tabSelection > 0
        let didMoveRight = translation < -minDragTranslationForSwipe && tabSelection < listCount - 1
        if didMoveLeft {
            tabSelection -= 1
        } else if didMoveRight {
            tabSelection += 1
        }
    }
}

struct HomeViewPreView: PreviewProvider {

    static var previews: some View {
        let viewModel = HomeViewModel()
        HomeView(viewModel: viewModel)
    }
}
