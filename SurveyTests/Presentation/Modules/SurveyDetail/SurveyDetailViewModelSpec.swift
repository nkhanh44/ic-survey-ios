//
//  SurveyDetailViewModelSpec.swift
//  Survey
//
//  Created by Khanh on 22/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import Nimble
import Quick
import SwiftUI

@testable import Survey

final class SurveyDetailViewModelSpec: QuickSpec {

    var input: SurveyDetailViewModel.Input!
    var output: SurveyDetailViewModel.Output!

    override func spec() {
        var viewModel: SurveyDetailViewModel!
        let startSurveyTrigger = PassthroughSubject<Void, Never>()

        describe("a SurveyDetailViewModel") {

            beforeEach {
                viewModel = SurveyDetailViewModel()

                self.input = SurveyDetailViewModel.Input(
                    startSurveyTrigger: startSurveyTrigger.asDriver()
                )
                self.output = viewModel.transform(self.input)
            }

            context("when tap next button returns success") {

                it("returns output willGoToNextSurvey with true") {
                    startSurveyTrigger.send(())

                    expect(self.output.willGoToNextSurvey).toEventually(beTrue())
                }
            }
        }
    }
}
