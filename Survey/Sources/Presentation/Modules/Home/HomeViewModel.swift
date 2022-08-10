//
//  HomeViewModel.swift
//  SurveyTests
//
//  Created by Khanh on 07/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct HomeViewModel {}

extension HomeViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        return Output()
    }
}

// MARK: - Input & Output

extension HomeViewModel {

    final class Input: ObservableObject {}

    final class Output: ObservableObject {

        var cancelBag = CancelBag()
    }
}
