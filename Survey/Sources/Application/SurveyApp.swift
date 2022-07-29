//
//  SurveyApp.swift
//  Survey
//
//  Created by Khanh on 22/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import IQKeyboardManagerSwift
import SwiftUI

@main
struct SurveyApp: App {

    var body: some Scene {
        configure()
        return WindowGroup {
            LoginView(viewModel: LoginViewModel())
        }
    }

    private func configure() {
        let IQKeyboard = IQKeyboardManager.shared
        IQKeyboard.enable = true
        IQKeyboard.shouldResignOnTouchOutside = true
    }
}
