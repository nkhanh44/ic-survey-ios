//
//  AuthenticationInterceptor.swift
//  Survey
//
//  Created by Khanh on 17/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire
import Foundation

final class AuthenticationInterceptor: RequestInterceptor {

    private var keychain: KeychainServiceProtocol

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
}
