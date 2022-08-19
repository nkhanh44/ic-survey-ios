//
//  HomeViewSpec.swift
//  Survey
//
//  Created by Khanh on 24/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick

@testable import Survey

final class HomeViewSpec: QuickSpec {

    override func spec() {
        var homeView: HomeView!

        describe("a homeView") {

            beforeEach {
                homeView = HomeView(
                    viewModel: HomeViewModel(
                        useCase: HomeUseCaseMock())
                )
            }

            context("has onAppear called") {

                it("is not loading") {
                    expect(homeView.output.isLoading) == false
                }
            }
        }
    }
}
