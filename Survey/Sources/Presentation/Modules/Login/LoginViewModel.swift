//
//  LoginViewModel.swift
//  Survey
//
//  Created by Khanh on 27/07/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Combine
import SwiftUI

struct LoginViewModel {

    let useCase: LogInUseCaseProtocol
}

extension LoginViewModel: ViewModel {

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()

        let isEmailValid = Publishers.CombineLatest(input.$email, input.emailTrigger)
            .map { $0.0.isEmailValid && !$0.0.isEmpty }

        let isPasswordValid = Publishers.CombineLatest(input.$password, input.passwordTrigger)
            .map { $0.0.isPasswordMustLeast8Letters && !$0.0.isEmpty }

        isEmailValid
            .assign(to: \.isEmailValid, on: output)
            .store(in: &output.cancelBag)

        isPasswordValid
            .assign(to: \.isPasswordValid, on: output)
            .store(in: &output.cancelBag)

        Publishers.CombineLatest(isEmailValid, isPasswordValid)
            .map { $0.0 && $0.1 }
            .assign(to: \.isLoginEnabled, on: output)
            .store(in: &output.cancelBag)

        input.logInTrigger
            .filter { output.isLoginEnabled }
            .map { _ in
                self.useCase.login(email: input.email, password: input.password)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: {
                KeychainAccess.remove()
                KeychainAccess.token = $0 as? KeychainToken
                output.isLoggedInSuccessfully = KeychainAccess.isLoggedIn
            })
            .store(in: &output.cancelBag)

        errorTracker
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: &output.cancelBag)

        activityTracker
            .receive(on: RunLoop.main)
            .assign(to: \.isLoading, on: output)
            .store(in: &output.cancelBag)

        return output
    }
}

// MARK: - Input & Output

extension LoginViewModel {

    final class Input: ObservableObject {

        @Published var email = ""
        @Published var password = ""
        let logInTrigger: Driver<Void>
        let emailTrigger: Driver<Void>
        let passwordTrigger: Driver<Void>

        init(logInTrigger: Driver<Void>, emailTrigger: Driver<Void>, passwordTrigger: Driver<Void>) {
            self.logInTrigger = logInTrigger
            self.emailTrigger = emailTrigger
            self.passwordTrigger = passwordTrigger
        }
    }

    final class Output: ObservableObject {

        var cancelBag = CancelBag()

        @Published var isLoginEnabled = false
        @Published var alert: AlertMessage?
        @Published var isLoading = false
        @Published var isLoggedInSuccessfully = false
        @Published var isEmailValid = true
        @Published var isPasswordValid = true
    }
}
