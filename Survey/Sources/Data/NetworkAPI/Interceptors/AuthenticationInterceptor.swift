//
//  AuthenticationInterceptor.swift
//  Survey
//
//  Created by Khanh on 17/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire
import Foundation
import Japx
import SwiftUI

final class AuthenticationInterceptor: RequestInterceptor {

    @EnvironmentObject private var appRouter: AppRouter

    private var keychain: KeychainServiceProtocol
    private var refreshRequest: AFRequest?

    init(keychain: KeychainServiceProtocol = KeychainService.shared) {
        self.keychain = keychain
    }

    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        if let token = try? keychain.get(key: .token) {
            request.headers.add(name: "Authorization", value: "\(token.tokenType) \(token.accessToken)")
            completion(.success(request))
        } else {
            completion(.failure(NetworkAPIError.generic))
        }
    }

    func retry(
        _ request: Alamofire.Request,
        for session: Session,
        dueTo error: Error,
        completion: @escaping (RetryResult) -> Void
    ) {
        guard request.retryCount == 0 else { return completion(.doNotRetry) }

        if refreshRequest != nil { return }

        refreshRequest = getRefreshToken { [weak self] result in
            switch result {
            case let .success(authToken):
                do {
                    try self?.keychain.set(newToken: KeychainToken(token: authToken), for: .token)
                    completion(.retry)
                } catch {
                    completion(.doNotRetryWithError(error))
                }
            case let .failure(error):
                completion(.doNotRetryWithError(error))
            }

            self?.refreshRequest = nil
        }
    }

    private func getRefreshToken(completion: @escaping (Result<Token, Error>) -> Void) -> AFRequest? {
        let path = "\(Constants.API.baseUrl)oauth/token"
        guard let refreshToken = try? keychain.get(key: .token)?.refreshToken else {
            completion(.failure(NetworkAPIError.generic))
            return nil
        }
        return AF.request(
            path,
            method: .post,
            parameters: [
                "grant_type": "refresh_token",
                "refresh_token": refreshToken,
                "client_id": Constants.Keys.clientId,
                "client_secret": Constants.Keys.clientSecret
            ]
        )
        .responseData { data in
            do {
                switch data.result {
                case let .success(data):
                    let result = try JapxDecoder().decode(
                        JapxResponse<APIToken>.self,
                        from: data
                    )
                    completion(.success(result.data))
                case .failure:
                    self.appRouter.state = .login
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
