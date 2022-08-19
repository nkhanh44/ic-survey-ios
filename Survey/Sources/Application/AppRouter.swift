//
//  AppRouter.swift
//  Survey
//
//  Created by Khanh on 04/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine

enum AppState {

    case splash
    case login
    case home
}

final class AppRouter: ObservableObject {

    @Published var state: AppState = .splash
}

