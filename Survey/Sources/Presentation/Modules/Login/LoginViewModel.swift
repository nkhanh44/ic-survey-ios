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

    let loginUseCase: LogInUseCaseProtocol
    let storeUseCase: StoreTokenUseCaseProtocol
}

extension LoginViewModel: ViewModel {
    // swiftlint:disable function_body_length
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(false)
        let output = Output()

        let isEmailValid = input.$email
            .map { $0.isEmailValid && !$0.isEmpty }
            .dropFirst()

        let isPasswordValid = input.$password
            .map { $0.isPasswordValid && !$0.isEmpty }
            .dropFirst()

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
                self.loginUseCase.login(email: input.email, password: input.password)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .switchToLatest()
            .map {
                self.storeUseCase.store(token: $0).asDriver()
            }
            .switchToLatest()
            .assign(to: \.isLoggedInSuccessfully, on: output)
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

        init(logInTrigger: Driver<Void>) {
            self.logInTrigger = logInTrigger
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
