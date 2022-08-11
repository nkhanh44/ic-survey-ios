//
//  KeychainServiceMock.swift
//  SurveyTests
//
//  Created by Khanh on 09/08/2022.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

@testable import Survey

final class KeychainServiceMock: KeychainServiceProtocol {

    var data: [String: Any?] = [:]

    func get(key: KeychainKeys) throws -> KeychainToken? {
        data[key.rawValue] as? KeychainToken
    }

    func set(newToken: KeychainToken?, for key: KeychainKeys) throws {
        data[key.rawValue] = newToken
    }

    func removeToken(with key: KeychainKeys) throws {
        data.removeValue(forKey: key.rawValue)
    }

    func isLoggedIn() throws -> Bool {
        data[KeychainKeys.token.rawValue] != nil
    }
}
